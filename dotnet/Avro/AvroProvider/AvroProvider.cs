using Avro;
using Avro.IO;
using Avro.Specific;
using System.Net;

namespace AvroProvider
{
    public class AvroProvider
    {
        static void Main(string[] args)
        {
            var cancellationTokenSource = new CancellationTokenSource();
            var cancellationToken = cancellationTokenSource.Token;

            var serverTask = StartServer(cancellationToken);

            // Wait for user input to stop the server
            Console.WriteLine("Press Ctrl+C to stop the server...");
            Console.ReadKey();

            // Signal cancellation to stop the server
            cancellationTokenSource.Cancel();

            // Wait for the server task to complete
            serverTask.Wait();
        }

        public static async Task StartServer(CancellationToken cancellationToken, string listenerUrl = "http://localhost:8080/")
        {
            // Load the user schema from the avsc file
            var schema = (RecordSchema)Schema.Parse(File.ReadAllText(Path.Join(Directory.GetCurrentDirectory(), "..", "..", "..", "..", "AvroProvider", "user.avsc")));
            // Create a user object
            var user = new User
            {
                Id = 1,
                Username = "matt",
            };

            // Serialize the user object to Avro binary format
            using var stream = new MemoryStream();
            var writer = new BinaryEncoder(stream);
            var avroWriter = new SpecificDefaultWriter(schema);
            avroWriter.Write(user, writer);
            writer.Flush();

            // Start the HTTP server
            var listener = new HttpListener();
            listener.Prefixes.Add(listenerUrl);
            listener.Start();
            Console.WriteLine("Server started. Listening for requests...");

            try
            {
                // Handle incoming requests
                while (!cancellationToken.IsCancellationRequested)
                {
                    var context = await listener.GetContextAsync();
                    var request = context.Request;
                    var response = context.Response;

                    if (request.Url?.AbsolutePath == "/avro")
                    {
                        // Set the response content type to Avro binary format
                        response.ContentType = "avro/binary;record=User";

                        // Write the Avro binary data to the response stream
                        response.ContentLength64 = stream.Length;
                        stream.Position = 0;
                        await stream.CopyToAsync(response.OutputStream);
                    }
                    else
                    {
                        // Return a 404 Not Found response for other endpoints
                        response.StatusCode = 404;
                        response.Close();
                    }
                }
            }
            catch (OperationCanceledException)
            {
                // Server was cancelled, do any cleanup here
                Console.WriteLine("Server stopped.");
            }
            finally
            {
                // Stop the listener
                listener.Stop();
                listener.Close();
            }
        }
    }
}
