using System;
using System.Text.Json;
using System.Threading.Tasks;
using FluentAssertions;
using Xunit;
using PactFfi;
using System.Runtime.InteropServices;

namespace GrpcGreeterClient.Tests
{
    public class GrpcGreeterClientTests
    {

        [Fact]
        public async Task ReturnsMismatchWhenNoGrpcClientRequestMade()
        {

            var version = Marshal.PtrToStringAnsi(Pact.Version());
            version.Should().Be("0.4.22");
            Pact.LoggerInit();
            Pact.LoggerAttachSink("stdout",3);
            Pact.LoggerApply();
            Pact.LogMessage("pact-dotnet","info",$"hello from ffi version: {version}");
            var host = "0.0.0.0";
            var pact = Pact.NewPact("foo","bar");
            var interaction = Pact.NewSyncMessageInteraction(pact,"a request to a plugin");
            Pact.WithSpecification(pact,Pact.PactSpecification.V4);
            var content = @"{
                    ""pact:proto"": ""/Users/saf/dev/you54f/hello_ffi/dotnet/Grpc/GrpcGreeterClient/Protos/greet.proto"",
                    ""pact:proto-service"": ""Greeter/SayHello"",
                    ""pact:content-type"": ""application/protobuf"",
                    ""request"": {
                    ""name"": ""matching(type, 'foo')""
                    },
                    ""response"": {
                    ""message"": [""matching(type, 'Hello foo')""]
                    }
                }";
            Pact.PluginAdd(pact,"protobuf","0.3.15");
            Pact.PluginInteractionContents(interaction,0,"application/grpc",content);

            var port = Pact.CreateMockServerForTransport(pact,host,0,"grpc",null);
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

            var version = Marshal.PtrToStringAnsi(Pact.Version());
            version.Should().Be("0.4.22");
            Pact.LoggerInit();
            Pact.LoggerAttachSink("stdout",3);
            Pact.LoggerApply();
            Pact.LogMessage("pact-dotnet","info",$"hello from ffi version: {version}");
            var host = "0.0.0.0";
            var pact = Pact.NewPact("grpc-greeter-client-dotnet","grpc-greeter");
            var interaction = Pact.NewSyncMessageInteraction(pact,"a request to a plugin");
            Pact.WithSpecification(pact,Pact.PactSpecification.V4);
            var content = @"{
                    ""pact:proto"": ""/Users/saf/dev/you54f/hello_ffi/dotnet/Grpc/GrpcGreeterClient/Protos/greet.proto"",
                    ""pact:proto-service"": ""Greeter/SayHello"",
                    ""pact:content-type"": ""application/protobuf"",
                    ""request"": {
                        ""name"": ""matching(type, 'foo')""
                    },
                    ""response"": {
                        ""message"": [""matching(type, 'Hello foo')""]
                    }
                }";

// TODO - Investigate matchers
// Failures:
// 1) Verifying a pact between grpc-greeter-client-dotnet and grpc-greeter - a request to a plugin
//     1.1) has a matching body
//            $.message -> Expected 'Hello foo' to be equal to 'hello foo'

            Pact.PluginAdd(pact,"protobuf","0.3.15");
            Pact.PluginInteractionContents(interaction,0,"application/grpc",content);

            var port = Pact.CreateMockServerForTransport(pact,host,0,"grpc",null);
            Console.WriteLine("Port: " + port);

            var client = new GreeterClientWrapper("http://localhost:" + port);
            var result = await client.SayHello("foo");
            Console.WriteLine("Result: " + result);

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
