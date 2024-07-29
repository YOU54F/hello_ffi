using System.Net;
using System.Net.Sockets;
using System.Text;

namespace TcpClient
{
    public class Program
    {
        static async Task Main(string[] args)
        {
            IPAddress localIpAddress = IPAddress.Parse("0.0.0.0");
            int port = 5001;

            await ConnectAndSendAsync(localIpAddress, port);
        }

        public static async Task<string> ConnectAndSendAsync(IPAddress ipAddress, int port)
        {
            var ipEndPoint = new IPEndPoint(ipAddress, port);
            Console.WriteLine($"Connecting to {ipAddress}:{port}");

            using System.Net.Sockets.TcpClient client = new();
            await client.ConnectAsync(ipEndPoint);
            await using NetworkStream stream = client.GetStream();

            var message = "MATT" + "hellotcp" + "MATT";
            var buffer = Encoding.UTF8.GetBytes(message);
            await stream.WriteAsync(buffer);
            var responseBuffer = new byte[1_024];

            int received = await stream.ReadAsync(responseBuffer);

            var response = Encoding.UTF8.GetString(responseBuffer, 0, received);
            Console.WriteLine($"Response received: \"{response}\"");
            return response;
        }
    }
}
