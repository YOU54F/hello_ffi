using GrpcPactPlugin.Services;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using System.Text.Json;



// Additional configuration is required to successfully run gRPC on macOS.
// For instructions on how to configure Kestrel and gRPC clients on macOS, visit https://go.microsoft.com/fwlink/?linkid=2099682

// app.Run();
public class InitMessage
{
    public int Port { get; set; }
    public string? ServerKey { get; set; }
}



class PactPluginServer
{
    public static async Task Main()
    {

        try
        {
            await RunAsync();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex);
            Console.WriteLine("Global error thrown. Exiting");
            throw;
        }
    }

    private static async Task RunAsync()
    {

        var builder = WebApplication.CreateBuilder();
        var port = Environment.GetEnvironmentVariable("PORT") is string p && p.Length > 0 ? 
                    Int32.Parse(p) : 50051;

        builder.WebHost.ConfigureKestrel(options =>
        {
            // Setup a HTTP/2 endpoint without TLS.
            options.ListenLocalhost(port, o => o.Protocols =
                HttpProtocols.Http2);
        });

        // Add services to the container.
        builder.Services.AddGrpc();

        var app = builder.Build();

        // Configure the HTTP request pipeline.
        app.MapGrpcService<PactPluginService>();



        var initMessage = new InitMessage
        {
            Port = port,
            ServerKey = "76bee28c-97b9-47c1-9684-30cb1e273051"
        };
        var serializeOptions = new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
        };

        string jsonString = JsonSerializer.Serialize<InitMessage>(initMessage, serializeOptions);



        app.Start();


        Console.WriteLine("Application started.");
        Console.WriteLine("Press ctrl+c to stop the server");
        await Task.Delay(2000);
        Console.WriteLine(jsonString);

        await app.WaitForShutdownAsync();
    }
}