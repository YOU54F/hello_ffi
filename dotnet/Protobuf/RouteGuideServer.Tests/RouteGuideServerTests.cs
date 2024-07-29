
using System;
using System.Threading.Tasks;
using FluentAssertions;
using Xunit;
using PactFfi;
using System.Runtime.InteropServices;
using System.Net;
using Routeguide;
using System.IO;
using Google.Protobuf;
using Newtonsoft.Json;

namespace RouteGuideServer.Tests
{
    public class RouteGuideServerTests
    {
        [Fact]
        public void ReturnsVerificationSuccessRunningProvider()
        {

            // setup a message handler proxy
            var listener = new HttpListener();
            listener.Prefixes.Add("http://localhost:5010/__messages/");
            listener.Start();

            _ = Task.Run(() =>
           {
               var context = listener.GetContext();

               if (context.Request.HttpMethod == "POST" && context.Request.Url.AbsolutePath == "/__messages")
               {
                   using var reader = new StreamReader(context.Request.InputStream);
                   var requestBody = reader.ReadToEnd();
                   Console.WriteLine($"Request Body: {requestBody}");
                   Console.WriteLine($"Request Path: {context.Request.Url.AbsolutePath}");

                   foreach (var header in context.Request.Headers.AllKeys)
                   {
                       Console.WriteLine($"{header}: {context.Request.Headers[header]}");
                   }
                   var requestBodyJson = JsonConvert.DeserializeObject<dynamic>(requestBody);
                   Console.WriteLine($"Request requestBodyJson: {requestBodyJson}");
                   Console.WriteLine($"Request requestBodyJson[description]: {requestBodyJson["description"]}");
                   // Map message description to action
                   if (requestBodyJson["description"] == "feature message")
                   {
                       var feature = new Feature
                       {
                           Name = "Sample Feature",
                           Location = new Point
                           {
                               Latitude = 123,
                               Longitude = 789
                           }
                       };

                       using var stream = new MemoryStream();
                       feature.WriteTo(stream);
                       context.Response.ContentType = "application/protobuf;message=Feature";
                       context.Response.ContentLength64 = stream.Length;
                       stream.Position = 0;
                       stream.CopyTo(context.Response.OutputStream);
                   }
                   else
                   {
                       // return a 404 response for other requests
                       context.Response.StatusCode = 404;
                       context.Response.Close();
                   }
               }
               else
               {
                   // return a 404 response for other requests
                   context.Response.StatusCode = 404;
                   context.Response.Close();
               }
           });

            _ = Pact.LogToStdOut(3);

            var verifier = Pact.VerifierNewForApplication("pact-dotnet", "0.0.0");
            Pact.VerifierSetProviderInfo(verifier, "grpc-greeter", null, null, 5099, null);
            // Pact.VerifierSetProviderState(verifier,"http://localhost:5010",new byte(),new byte());
            Pact.AddProviderTransport(verifier, "message", 5010, "/__messages", "http");
            Pact.VerifierAddFileSource(verifier, "../../../../pacts/protobufmessageconsumer-protobufmessageprovider.json");


            // Act
            var VerifierExecuteResult = Pact.VerifierExecute(verifier);
            VerifierExecuteResult.Should().Be(0);
            Pact.VerifierShutdown(verifier);

        }
    }
}
