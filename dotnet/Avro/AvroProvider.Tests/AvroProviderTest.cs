using FluentAssertions;
using Xunit;
using PactFfi;
using System.Threading.Tasks;

namespace AvroProvider.Tests
{
    public class AvroProviderTests
    {

        [Fact]
        public void ReturnsVerificationFailureWhenNoRunningProvider()
        {
            _ = Pact.LogToStdOut(3);

            var verifier = Pact.VerifierNewForApplication("pact-dotnet","0.0.0");
            Pact.VerifierSetProviderInfo(verifier,"AvroProvider",null,null,8081,null);
            Pact.VerifierAddFileSource(verifier,"../../../../pacts/AvroConsumer-AvroProvider.json");
            var VerifierExecuteResult = Pact.VerifierExecute(verifier);
            VerifierExecuteResult.Should().Be(1);
        }
        [Fact]
        public async Task ReturnsVerificationSuccessRunningProviderAsync()
        {
            _ = Pact.LogToStdOut(3);
            ushort port = 8080;
            var verifier = Pact.VerifierNewForApplication("pact-dotnet", "0.0.0");
            Pact.VerifierSetProviderInfo(verifier,"AvroProvider",null,null,port,null);
            Pact.VerifierAddFileSource(verifier,"../../../../pacts/AvroConsumer-AvroProvider.json");

            // // Arrange
            // // Setup our app to run before our verifier executes
            // // Setup a cancellation token so we can shutdown the app after
            var cts = new System.Threading.CancellationTokenSource();
            var token = cts.Token;
            var runAppTask = Task.Run(async () =>
            {
                await AvroProvider.StartServer(token, "http://localhost:" + port + "/");
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
