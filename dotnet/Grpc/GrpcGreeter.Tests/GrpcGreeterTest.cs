using System;
using System.Text.Json;
using System.Threading.Tasks;
using System.Threading;
using FluentAssertions;
using Xunit;
using PactFfi;
using System.Runtime.InteropServices;

namespace GrpcGreeter.Tests
{
    public class GrpcGreeterTests
    {

        [Fact]
        public async Task ReturnsVerificationFailureWhenNoRunningProvider()
        {

            var version = Marshal.PtrToStringAnsi(Pact.Version());
            version.Should().Be("0.4.22");
            Pact.LoggerInit();
            Pact.LoggerAttachSink("stdout",4);
            Pact.LoggerApply();
            Pact.LogMessage("pact-dotnet","info",$"hello from ffi version: {version}");
            await Task.Delay(1);

            var verifier = Pact.VerifierNewForApplication("pact-dotnet","0.0.0");
            Pact.VerifierSetProviderInfo(verifier,"grpc-greeter",null,null,0,null);
            Pact.AddProviderTransport(verifier, "grpc",5060,"/","http");
            Pact.VerifierAddFileSource(verifier,"../../../../pacts/grpc-greeter-client-dotnet-grpc-greeter.json");
            var VerifierExecuteResult = Pact.VerifierExecute(verifier);
            VerifierExecuteResult.Should().Be(1);
        }
        [Fact]
        public void ReturnsVerificationSuccessRunningProvider()
        {
            var version = Marshal.PtrToStringAnsi(Pact.Version());
            version.Should().Be("0.4.22");
            Pact.LoggerInit();
            Pact.LoggerAttachSink("stdout", 3);
            Pact.LoggerApply();
            Pact.LogMessage("pact-dotnet", "info", $"hello from ffi version: {version}");
            var verifier = Pact.VerifierNewForApplication("pact-dotnet", "0.0.0");
            Pact.VerifierSetProviderInfo(verifier, "grpc-greeter", null, null, 0, null);
            Pact.AddProviderTransport(verifier, "grpc", 5000, "/", "https");
            Pact.VerifierAddFileSource(verifier, "../../../../pacts/grpc-greeter-client-dotnet-grpc-greeter.json");

            // Arrange
            // Setup our app to run before our verifier executes
            // Setup a cancellation token so we can shutdown the app after
            var cts = new CancellationTokenSource();
            var token = cts.Token;
            var runAppTask = Task.Run(async () =>
            {
                await GrpcGreeterService.RunApp(new string[] { }, token);
            }, token);

            // Act
            var VerifierExecuteResult = Pact.VerifierExecute(verifier);
            VerifierExecuteResult.Should().Be(0);
            Pact.VerifierShutdown(verifier);
            // After test execution, signal the task to terminate
            cts.Cancel();
        }
    }
}
