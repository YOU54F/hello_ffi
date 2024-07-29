using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace TcpListener
{
    public class TcpListener
    {
        public static async Task Main(string[] args)
        {
            string url = "127.0.0.1";
            int port = 5001;
            CancellationTokenSource cts = new CancellationTokenSource();
            Task listenerTask = StartTcpListener(url, port, Console.WriteLine, cts.Token);
            
            // Perform other operations or wait for a cancellation signal
            
            // To cancel the listener, call cts.Cancel()
            
            await listenerTask;
        }

        public static async Task StartTcpListener(string url, int port, Action<string> logger, CancellationToken cancellationToken)
        {
            IPAddress localIpAddress = IPAddress.Parse(url);
            System.Net.Sockets.TcpListener listener = new(localIpAddress, port);
            logger($"Running on {url}:{port}");

            try
            {
                listener.Start();

                TcpClient handler = await listener.AcceptTcpClientAsync();
                NetworkStream stream = handler.GetStream();
                logger("Received request");
                byte[] buffer = new byte[1024];
                int bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length, cancellationToken);
                string request = Encoding.UTF8.GetString(buffer, 0, bytesRead);
                logger($"Received request contents: {request}");

                var message = "MATTtcpworldMATT\n";
                var dateTimeBytes = Encoding.UTF8.GetBytes(message);
                await stream.WriteAsync(dateTimeBytes, cancellationToken);

                // Get value between "MATT" tags
                string value = GetValueBetweenTags(request, "MATT");
                logger($"Value between tags: {value}");

                logger($"Sent message: \"{message}\"");
                // Sample output:
                //     Sent message: "📅 8/22/2022 9:07:17 AM 🕛"
            }
            finally
            {
                listener.Stop();
            }
        }

        public static string GetValueBetweenTags(string request, string v)
        {
            int startIndex = request.IndexOf(v) + v.Length;
            int endIndex = request.LastIndexOf(v);
            if (startIndex < 0 || endIndex < 0)
            {
                throw new ArgumentException($"Value between tags '{v}' not found in request.");
            }
            return request[startIndex..endIndex];
        }
    }
}
