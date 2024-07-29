using System;
using System.Text.Json;
using System.Threading.Tasks;
using FluentAssertions;
using Xunit;
using PactFfi;
using System.Runtime.InteropServices;
using System.IO;
namespace AvroClient.Tests
{
    public class AvroClientTests
    {

        [Fact]
        public async Task ReturnsMismatchWhenNoAvroClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);
            var host = "0.0.0.0";
            var pact = Pact.NewPact("AvroConsumer", "AvroProvider");
            var interaction = Pact.NewInteraction(pact, "A request to do get some Avro stuff");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var content = $@"{{
                    ""pact:avro"":""{Path.Join(Directory.GetCurrentDirectory(), "..", "..", "..", "..", "AvroClient", "user.avsc").Replace("\\", "\\\\")}"",
                    ""pact:record-name"": ""User"",
                    ""pact:content-type"": ""avro/binary"",
                    ""id"": ""matching(number, 1)"",
                    ""username"": ""notEmpty('matt')""
                }}";
            Pact.PluginAdd(pact, "avro", "0.0.5");
            Pact.WithRequest(interaction,"GET", "/avro");
            Pact.ResponseStatus(interaction,200);
            Pact.PluginInteractionContents(interaction, Pact.InteractionPart.Response, "avro/binary", content);

            var port = Pact.CreateMockServerForTransport(pact, host, 0, null, null);
            Console.WriteLine("Port: " + port);

            var matched = Pact.MockServerMatched(port);
            Console.WriteLine("Matched: " + matched);
            matched.Should().BeFalse();

            var MismatchesPtr = Pact.MockServerMismatches(port);
            var MismatchesString = Marshal.PtrToStringAnsi(MismatchesPtr);
            Console.WriteLine("Mismatches: " + MismatchesString);
            var MismatchesJson = JsonSerializer.Deserialize<JsonElement>(MismatchesString);
            var ErrorString = MismatchesJson[0].GetProperty("type").GetString();
            var ExpectedPath = MismatchesJson[0].GetProperty("path").GetString();

            ErrorString.Should().Be("missing-request");
            ExpectedPath.Should().Be("/avro");

            Pact.CleanupMockServer(port);
            Pact.PluginCleanup(pact);
            await Task.Delay(1);
        }
        [Fact]
        public async Task WritesPactWhenGrpcClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);
            var host = "0.0.0.0";
            var pact = Pact.NewPact("AvroConsumer", "AvroProvider");
            var interaction = Pact.NewInteraction(pact, "A request to do get some Avro stuff");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var content = $@"{{
                    ""pact:avro"":""{Path.Join(Directory.GetCurrentDirectory(), "..", "..", "..", "..", "AvroClient", "user.avsc").Replace("\\", "\\\\")}"",
                    ""pact:record-name"": ""User"",
                    ""pact:content-type"": ""avro/binary"",
                    ""id"": ""matching(number, 1)"",
                    ""username"": ""notEmpty('matt')""
                }}";
            Pact.PluginAdd(pact, "avro", "0.0.5");
            Pact.WithRequest(interaction,"GET", "/avro");
            Pact.ResponseStatus(interaction,200);
            Pact.PluginInteractionContents(interaction, Pact.InteractionPart.Response, "avro/binary", content);

            var port = Pact.CreateMockServerForTransport(pact, host, 0, null, null);
            Console.WriteLine("Port: " + port);

            // act - call avro client
            var result = await AvroClient.RunAvroClient("http://localhost:" + port);
            Console.WriteLine("Result: " + result);
            // assert 
            result.Id.Should().Be(1);
            result.Username.Should().Be("matt");

            // pact - internal assert 
            var matched = Pact.MockServerMatched(port);
            Console.WriteLine("Matched: " + matched);
            matched.Should().BeTrue();

            var MismatchesPtr = Pact.MockServerMismatches(port);
            var MismatchesString = Marshal.PtrToStringAnsi(MismatchesPtr);
            Console.WriteLine("Mismatches: " + MismatchesString);

            MismatchesString.Should().Be("[]");

            // pact - internal finalise and cleanup 
            var writeRes = Pact.WritePactFileForPort(port, "../../../../pacts", false);
            Console.WriteLine("WriteRes: " + writeRes);
            Pact.CleanupMockServer(port);
            Pact.PluginCleanup(pact);
        }

        

    }
}
