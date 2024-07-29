# Pact Plugin Template

<img src="https://user-images.githubusercontent.com/19932401/206557102-f5141b7d-a4f4-441b-84f6-ede3552c4696.png" height="3.5%" width="3.5%"><img src="https://dotnet.microsoft.com/static/images/redesign/social/square.png" height="3.5%" width="3.5%">


Template project to help bootstrap a new Pact [Plugin](https://github.com/pact-foundation/pact-plugins) for the [Pact](http://docs.pact.io) framework. 

**Features:**

* Stubbed gRPC methods ready to implement
* Automated release procedure
* Support for recommended common platform/targets
* Levelled logging for observability

**TODO**

- [ ] Support Matchers and Generators (requires FFI package support)

## Repository Structure


```

├── README.md                # This file!
├── Makefile                 # Build configuration            (✅ fill me in!)
├── Program.cs               # The gRPC server handler            
├── Services
│   └── PactPluginService.cs # The gRPC server implementation (✅ fill me in!)
├── Protos                   # Plugin configuration file - set to use the binary distributable
│   └── plugin.proto         # Location of protobuf for the Pact Plugin Framework
├── pact-plugin.json
├── build                    # This is where your binary distributions will be output
├── GrpcPactPlugin           # This is will be the name of the plugin, yours will change
├── GrpcPactPlugin.csproj    # The project config file
├── Properties
│   └── launchSettings.json  # The project dependencies file
├── appsettings.json         # The project settings file
├── evans.sh                 # A quick tool to help you test your plugin
└── test
    └── pact-js              # A test with Pact-JS to exercise the plugin
└── .github/workflows        # This holds your CI build and release configuration
├── RELEASING.md             # Instructions on how to release 🚀
```

## Developing the plugin

### Prerequsites

The protoc compiler must be installed for this plugin 

See .NET specific instructions [here](https://github.com/grpc/grpc-dotnet#to-start-using-grpc-for-net)
and the official Microsoft docs [page](https://learn.microsoft.com/en-us/aspnet/core/grpc/protobuf?view=aspnetcore-7.0) for knowledge about construction Protobuf messages in .NET

### Create your new repository

1. Clone this repository 
2. Create a new repository in GitHub. The name of the plugin should be `pact-<PROJECT>-plugin` e.g. `pact-protobuf-plugin`
3. Push this code to your new repository

### Install the project dependencies

Run:

```
make build
```

which is an alias for 

```
dotnet build
```

To ensure the dependencies and vendoring are correct.

### Set the name and version

In the top of the [`Makefile`](./Makefile) set `PROJECT` to your plugin's name.

`PROJECT` should map to `<PROJECT>` in your GitHub repository.

*NOTE: It's important that the name of your GitHub project and the `PROJECT` variable must align, to create artifacts discoverable to the CLI tooling, such as the [Plugin CLI](https://docs.pact.io/implementation_guides/pact_plugins/cli).*

### Design the consumer interface

This is how the users of your plugin will write the plugin specific interaction details. 

For example, take the following HTTP interaction:

```js
await pact
  .addInteraction()
  .given('the Matt protocol exists')
  .uponReceiving('an HTTP request to /matt')
  .usingPlugin({
    plugin: 'matt',
    version: '0.0.4',
  })
  .withRequest('POST', '/matt', (builder) => {
    builder.pluginContents('application/matt', mattRequest); // <- request
  })
  .willRespondWith(200, (builder) => {
    builder.pluginContents('application/matt', mattResponse); // <- response
  })
  .executeTest((mockserver) => {
          ...
```          

The user needs to specify the request and response body portion of the request.

Because the use cases for plugins are so wide and varied, the framework does not impose limits
on this data structure and is something you need to design.

This being said, most plugins have opted to use a JSON structure. 

This structure is represented in our GoLang template in [`configuration.go`](https://github.com/pact-foundation/pact-plugin-template-golang/blob/main/configuration.go)

Think about how you would like your user to specify the interaction details for the various interaction types. 

Here is an example for a TCP plugin with a custom text protocol:

#### Synchronous Messages

Set the expected response from the API:

```go
mattMessage := `{"response": {"body": "hellotcp"}}`
```

#### Asynchronous Messages

Set the request/response all in one go:

```go
mattMessage := `{"request": {"body": "hellotcp"}, "response":{"body":"tcpworld"}}`
```

#### HTTP

Separate out the body on the request/response part of the interaction:

```go
mattRequest := `{"request": {"body": "hello"}}`
mattResponse := `{"response":{"body":"world"}}`
```

### Write the Plugin!

#### Implement the relevant RPC functions

Open [`PactPluginService.cs`](./Services/PactPluginService.cs) and update the relevant RPC functions. 

Depending on your use case, some of the RPC calls won't be required, each method is well signposted to help you along.

#### Logging

You should log regularly. Debugging gRPC calls from the framework can be challenging, as the plugin is started asynchronously by the Plugin Driver behind the scenes.

There are two ways to log:

1. Stdout - all stdout (e.g. `print`) is pulled into the general Pact logs for the framework you're running
2. To file. All calls to `log` will be written to a file

The log setup has three main features:

1. [X] It works with the native `C#` package
2. [ ] It logs to a file relative to plugin execution in `log/plugin.log`
3. [ ] It is levelled, at the direction of the plugin driver (that is, the log level will pass in from the driver which will restrict the levels logged in this plugin)

<!-- To write something to the log file, you simply call the `log` method, with the level prefixed as per below: -->
To write something to stdout, you simply call the `Console.WriteLine` method

`log(message)`

<!-- ```golang
log.Println("[TRACE] ...")
log.Println("[DEBUG] ...")
log.Println("[INFO] ...")
log.Println("[WARN] ...")
log.Println("[ERROR] ...")
``` -->

### Publish your plugin

Follow the steps in [Releasing](./RELEASING.md) to publish a new version of your Plugin.

## Local Development

The following command will build the plugin, and install into the correct plugin directory for local development:

```
make install_local
```

You can then reference your plugin in local tests to try it out.

### Regenerating the plugin protobuf definitions

If a new protobuf definition is required (e.g. to support a new feature), copy it into the `Protos` folder and run the following Make task:

> Need to add annotation in the protofile `option csharp_namespace = "GrpcPactPlugin"` for an idiomatic naming convention for C#

```
make proto
```

It will update the definitions in the `./obj/Debug/net6.0` packages. Note this may result in a breaking change, depending on the version. So upgrade carefully and ensure you have appropriate tests

## Supported targets

This code base should automatically create artifacts for the following OS/Architecture combiations:

| OS      | Architecture | Supported |
| ------- | ------------ | --------- |
| OSX     | x86_64       | ✅         |
| OSX     | arm          | ✅         |
| Linux   | x86_64       | ✅         |
| Linux   | arm          | ✅         |
| Windows | x86_64       | ✅         |
| Windows | arm          | ✅         |

## .NET Development notes

1. Install .NET 6+
2. Open the Project.
3. Run `dotnet run`
4. Build with `dotnet build`
   1. Different options for different archs `https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-build`
   2. For full list see https://github.com/dotnet/runtime/blob/main/src/libraries/Microsoft.NETCore.Platforms/src/runtime.json
