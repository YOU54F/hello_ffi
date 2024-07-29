// Copyright 2015 gRPC authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

namespace Routeguide
{
    class Program
    {
        static async Task Main(string[] args)
        {

            var features = RouteGuideUtil.LoadFeatures();

            var host = Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.ConfigureServices(services =>
                    {
                        services.AddGrpc();
                        services.AddSingleton<List<Feature>>();
                    });

                    webBuilder.Configure(app =>
                    {
                        app.UseRouting();

                        app.UseEndpoints(endpoints =>
                        {
                            endpoints.MapGrpcService<RouteGuideImpl>();
                            endpoints.MapGet("/", context =>
                            {
                                return context.Response.WriteAsync("Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");
                            });
                        });
                    });
                })
                .Build();

            var cancellationTokenSource = new CancellationTokenSource();
            var periodicCancellationTask = PeriodicallyCheckCancellation(cancellationTokenSource.Token, cancellationTokenSource);

            await host.RunAsync();

            cancellationTokenSource.Cancel();
            await periodicCancellationTask;
        }

        private static async Task PeriodicallyCheckCancellation(CancellationToken cancellationToken, CancellationTokenSource periodicCancellationToken)
        {
            while (!cancellationToken.IsCancellationRequested)
            {
                if (periodicCancellationToken.Token.IsCancellationRequested)
                {
                    periodicCancellationToken.Cancel();
                    break;
                }

                await Task.Delay(1000); // Check for cancellation every second
            }
        }
    }
}


// using RouteGuide.Services;

// public class RouteGuideService
// {
//     public static async Task Main(string[] args)
//     {
//         await RunApp(args, CancellationToken.None);
//     }

//     public static async Task RunApp(string[] args, CancellationToken cancellationToken)
//     {
//         var builder = WebApplication.CreateBuilder(args);

//         // Add services to the container.
//         builder.Services.AddGrpc();

//         var app = builder.Build();

//         // Configure the HTTP request pipeline.
//         app.MapGrpcService<RouteGuideService>();
//         app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

//         var cancellationTokenSource = new CancellationTokenSource();
//         var periodicCancellationTask = PeriodicallyCheckCancellation(cancellationToken, cancellationTokenSource);

//         await app.RunAsync();

//         cancellationTokenSource.Cancel();
//         await periodicCancellationTask;
//     }

//     private static async Task PeriodicallyCheckCancellation(CancellationToken cancellationToken, CancellationTokenSource periodicCancellationToken)
//     {
//         while (!cancellationToken.IsCancellationRequested)
//         {
//             if (periodicCancellationToken.Token.IsCancellationRequested)
//             {
//                 periodicCancellationToken.Cancel();
//                 break;
//             }

//             await Task.Delay(1000); // Check for cancellation every second
//         }
//     }
// }
