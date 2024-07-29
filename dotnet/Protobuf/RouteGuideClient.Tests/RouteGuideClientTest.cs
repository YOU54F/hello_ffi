using System;
using Xunit;
using PactFfi;
using System.IO;
namespace RouteGuideClient.Tests
{
    public class RouteGuideClientTests
    {

        [Fact]
        public void ReturnsMismatchWhenNoProtobufClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);

            var pact = Pact.NewPact("protobufmessageconsumer", "protobufmessageprovider");
            var interaction = Pact.NewMessageInteraction(pact, "feature message");
            Pact.Given(interaction, "the world exists");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var content = $@"{{
                    ""pact:proto"":""{Path.Join(Directory.GetCurrentDirectory(), "..", "..", "..", "..", "Protos", "route_guide.proto").Replace("\\", "\\\\")}"",
                    ""pact:message-type"": ""Feature"",
                    ""pact:content-type"": ""application/protobuf"",
                    ""name"": ""notEmpty('Big Tree')"",
                    ""location"": {{
                        ""latitude"": ""matching(number, 180)"",
                        ""longitude"": ""matching(number, 200)""
                    }}
                }}";
            Pact.PluginAdd(pact, "protobuf", "0.4.0");
            Pact.PluginInteractionContents(interaction, 0, "application/protobuf", content);

            // TODO perform mismatch logic

            Pact.PluginCleanup(pact);
        }
        [Fact]
        public void WritesPactWhenGrpcClientRequestMade()
        {

            _ = Pact.LogToStdOut(3);
            // var host = "0.0.0.0";
            var pact = Pact.NewPact("protobufmessageconsumer", "protobufmessageprovider");
            var interaction = Pact.NewMessageInteraction(pact, "feature message");
            Pact.Given(interaction, "the world exists");
            Pact.WithSpecification(pact, Pact.PactSpecification.V4);
            var content = $@"{{
                    ""pact:proto"":""{Path.Join(Directory.GetCurrentDirectory(), "..", "..", "..", "..", "Protos", "route_guide.proto").Replace("\\", "\\\\")}"",
                    ""pact:message-type"": ""Feature"",
                    ""pact:content-type"": ""application/protobuf"",
                    ""name"": ""notEmpty('Big Tree')"",
                    ""location"": {{
                        ""latitude"": ""matching(number, 180)"",
                        ""longitude"": ""matching(number, 200)""
                    }}
                }}";
            Pact.PluginAdd(pact, "protobuf", "0.4.0");
            Pact.PluginInteractionContents(interaction, 0, "application/protobuf", content);

            // TODO perform message logic

            var writeRes = Pact.WriteMessagePactFile(pact, "../../../../pacts", false);
            Console.WriteLine("WriteRes: " + writeRes);
            Pact.PluginCleanup(pact);
        }

    }
}
