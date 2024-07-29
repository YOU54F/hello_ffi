using FluentAssertions;
using Xunit;
using PactFfi;
using System.Threading.Tasks;
using System.Threading;
using System;

namespace TcpListener.Tests
{
    public class TcpListenerTests
    {

        [Fact]
        public async Task ReturnsVerificationSuccessTcpPluginAsync()
        {
            _ = Pact.LogToStdOut(3);
            string url = "127.0.0.1";
            ushort port = 5001;
            var verifier = Pact.VerifierNewForApplication("pact-dotnet", "0.0.0");
            Pact.VerifierSetProviderInfo(verifier, "matttcpprovider", null, "0.0.0.0", 5001, null);
            Pact.AddProviderTransport(verifier, "matt", port, "/", "tcp");
            // Pact.VerifierAddFileSource(verifier, "../../../../pacts/MattConsumer-MattProvider.json");
            Pact.VerifierAddFileSource(verifier, "../../../../pacts/matttcpconsumer-matttcpprovider.json");

            // // Arrange
            // // Setup our app to run before our verifier executes
            // // Setup a cancellation token so we can shutdown the app after
            CancellationTokenSource cts = new CancellationTokenSource();
            var token = cts.Token;
            var runAppTask = Task.Run(async () =>
            {
                await TcpListener.StartTcpListener(url, port, Console.WriteLine, token);
            }, token);
            await Task.Delay(2000);

            // Act
            var VerifierExecuteResult = Pact.VerifierExecute(verifier);
            VerifierExecuteResult.Should().Be(0);
            Pact.VerifierShutdown(verifier);
            // After test execution, signal the task to terminate
            cts.Cancel();
        }
    }
}
