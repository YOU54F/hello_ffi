using Avro;
using Avro.IO;
using Avro.Specific;

namespace AvroClient
{
    public class AvroClient
    {
        static async Task Main(string[] args)
        {
            await RunAvroClient();
        }

        public static async Task<User> RunAvroClient(string avroProviderUrl = "http://localhost:8080")
        {
            // Load the user schema from the avsc file
            var schema = (RecordSchema)Schema.Parse(File.ReadAllText(Path.Join(Directory.GetCurrentDirectory(), ".." , "..", "..", "..","AvroClient","user.avsc")));

            // Make an HTTP request to the AvroProvider
            var client = new HttpClient(new HttpClientHandler() { UseDefaultCredentials = true });
            var response = await client.GetAsync(avroProviderUrl + "/avro");

            // Get the response from the AvroProvider
            var responseStream = await response.Content.ReadAsStreamAsync();

            // Deserialize the Avro binary data from the response stream
            var reader = new BinaryDecoder(responseStream);
            var avroReader = new SpecificDefaultReader(schema, schema);
            var deserializedUser = new User();
            avroReader.Read(deserializedUser, reader);

            // Print the deserialized user object
            Console.WriteLine($"Deserialized User: Id={deserializedUser.Id}, Username={deserializedUser.Username}");
            return deserializedUser;
        }
    }
}
