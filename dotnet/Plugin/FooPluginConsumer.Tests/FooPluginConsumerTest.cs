using System;
using System.Text.Json;
using System.Threading.Tasks;
using FluentAssertions;
using Xunit;
using PactFfi;
using System.Runtime.InteropServices;
using System.IO;

namespace FooPluginConsumer.Tests
{
    public class FooPluginConsumerTests
    {

        [Fact]
        public void ReturnsMismatchWhenNoPluginClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);

            var host = "0.0.0.0";
            var pact = Pact.NewPact("FooPluginConsumer", "FooPluginProvider");
            var interaction = Pact.NewInteraction(pact, "a HTTP request to /foobar");
            Pact.WithRequest(interaction, "POST", "/foobar");
            Pact.Given(interaction, "the Foobar protocol exists");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var requestContent = $@"{{
                    ""request"": {{
                        ""body"": ""hello""
                    }}
                }}";
            var responseContent = $@"{{
                    ""response"": {{
                        ""body"": ""world""
                    }}
                }}";
            Pact.PluginAdd(pact, "dotnet-template", "0.0.0");
            Pact.PluginInteractionContents(interaction, Pact.InteractionPart.Request, "application/foo", requestContent);
            Pact.PluginInteractionContents(interaction, Pact.InteractionPart.Response, "application/foo", responseContent);

            var port = Pact.CreateMockServerForTransport(pact, host, 0, "http", null);
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
            ExpectedPath.Should().Be("/foobar");

            Pact.CleanupMockServer(port);
            Pact.PluginCleanup(pact);
        }

        [Fact]
        public void WritesPactWhenPluginClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);
            var host = "0.0.0.0";
            var pact = Pact.NewPact("DotnetPluginConsumer", "DotnetPluginProvider");
            var interaction = Pact.NewInteraction(pact, "a HTTP request to /foobar");
            Pact.WithRequest(interaction, "POST", "/foobar");
            Pact.Given(interaction, "the Foobar protocol exists");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var requestContent = $@"{{
                    ""request"": {{
                        ""body"": ""hello""
                    }}
                }}";
            var responseContent = $@"{{
                    ""response"": {{
                        ""body"": ""world""
                    }}
                }}";
            Pact.PluginAdd(pact, "dotnet-template", "0.0.0");
            Pact.PluginInteractionContents(interaction, Pact.InteractionPart.Request, "application/foo", requestContent);
            Pact.PluginInteractionContents(interaction, Pact.InteractionPart.Response, "application/foo", responseContent);

            var port = Pact.CreateMockServerForTransport(pact, host, 0, "http", null);
            Console.WriteLine("Port: " + port);

            // TODO - Make plugin http request

            // var matched = Pact.MockServerMatched(port);
            // Console.WriteLine("Matched: " + matched);
            // matched.Should().BeTrue();

            // var MismatchesPtr = Pact.MockServerMismatches(port);
            // var MismatchesString = Marshal.PtrToStringAnsi(MismatchesPtr);
            // Console.WriteLine("Mismatches: " + MismatchesString);

            // MismatchesString.Should().Be("[]");

            var writeRes = Pact.WritePactFileForPort(port, "../../../../pacts", false);
            Console.WriteLine("WriteRes: " + writeRes);
            Pact.CleanupMockServer(port);
            Pact.PluginCleanup(pact);
        }
    }
}
