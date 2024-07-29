using System;
using System.Text.Json;
using System.Threading.Tasks;
using FluentAssertions;
using Xunit;
using PactFfi;
using System.Runtime.InteropServices;
using System.IO;

namespace GrpcGreeterClient.Tests
{
    public class GrpcGreeterClientTests
    {

        [Fact]
        public async Task ReturnsMismatchWhenNoGrpcClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);
            // arrange
            var host = "0.0.0.0";
            var pact = Pact.NewPact("grpc-greeter-client", "grpc-greeter");
            var interaction = Pact.NewSyncMessageInteraction(pact, "a request to a plugin");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var content = $@"{{
                    ""pact:proto"":""{Path.Join(Directory.GetCurrentDirectory(), "..", "..", "..", "..", "GrpcGreeterClient", "Protos", "greet.proto").Replace("\\", "\\\\")}"",
                    ""pact:proto-service"": ""Greeter/SayHello"",
                    ""pact:content-type"": ""application/protobuf"",
                    ""request"": {{
                        ""name"": ""matching(type, 'foo')""
                    }},
                    ""response"": {{
                        ""message"": ""matching(type, 'Hello foo')""
                    }}
                }}";
            Pact.PluginAdd(pact, "protobuf", "0.4.0");
            Pact.PluginInteractionContents(interaction, 0, "application/grpc", content);

            var port = Pact.CreateMockServerForTransport(pact, host, 0, "grpc", null);
            Console.WriteLine("Port: " + port);

            var matched = Pact.MockServerMatched(port);
            Console.WriteLine("Matched: " + matched);
            matched.Should().BeFalse();

            var MismatchesPtr = Pact.MockServerMismatches(port);
            var MismatchesString = Marshal.PtrToStringAnsi(MismatchesPtr);
            Console.WriteLine("Mismatches: " + MismatchesString);
            var MismatchesJson = JsonSerializer.Deserialize<JsonElement>(MismatchesString);
            var ErrorString = MismatchesJson[0].GetProperty("error").GetString();
            var ExpectedPath = MismatchesJson[0].GetProperty("path").GetString();

            ErrorString.Should().Be("Did not receive any requests for path 'Greeter/SayHello'");
            ExpectedPath.Should().Be("Greeter/SayHello");

            Pact.CleanupMockServer(port);
            Pact.PluginCleanup(pact);
            await Task.Delay(1);
        }
        [Fact]
        public async Task WritesPactWhenGrpcClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);
            // arrange
            var host = "0.0.0.0";
            var pact = Pact.NewPact("grpc-greeter-client", "grpc-greeter");
            var interaction = Pact.NewSyncMessageInteraction(pact, "a request to a plugin");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var content = $@"{{
                    ""pact:proto"":""{Path.Join(Directory.GetCurrentDirectory(), "..", "..", "..", "..", "GrpcGreeterClient", "Protos", "greet.proto").Replace("\\", "\\\\")}"",
                    ""pact:proto-service"": ""Greeter/SayHello"",
                    ""pact:content-type"": ""application/protobuf"",
                    ""request"": {{
                        ""name"": ""matching(type, 'foo')""
                    }},
                    ""response"": {{
                        ""message"": ""matching(type, 'Hello foo')""
                    }}
                }}";

            Pact.PluginAdd(pact, "protobuf", "0.4.0");
            Pact.PluginInteractionContents(interaction, 0, "application/grpc", content);

            var port = Pact.CreateMockServerForTransport(pact, host, 0, "grpc", null);
            Console.WriteLine("Port: " + port);

            // act
            var client = new GreeterClientWrapper("http://localhost:" + port);
            var result = await client.SayHello("foo");
            Console.WriteLine("Result: " + result);

            // assert
            result.Should().Be("Hello foo");
            var matched = Pact.MockServerMatched(port);
            Console.WriteLine("Matched: " + matched);
            matched.Should().BeTrue();

            var MismatchesPtr = Pact.MockServerMismatches(port);
            var MismatchesString = Marshal.PtrToStringAnsi(MismatchesPtr);
            Console.WriteLine("Mismatches: " + MismatchesString);

            MismatchesString.Should().Be("[]");

            var writeRes = Pact.WritePactFileForPort(port, "../../../../pacts", false);
            Console.WriteLine("WriteRes: " + writeRes);
            Pact.CleanupMockServer(port);
            Pact.PluginCleanup(pact);
        }

    }
}
