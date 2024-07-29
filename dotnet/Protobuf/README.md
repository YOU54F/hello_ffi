# gRPC .NET Sample

Adapted for Pact, from Microsoft's gRPC sample - Tutorial: Create a gRPC client and server in ASP.NET Core

https://learn.microsoft.com/en-us/aspnet/core/tutorials/grpc/grpc-start?view=aspnetcore-8.0&tabs=visual-studio-mac


1. "transport" not written to pact file

      "transport": "grpc",
      "type": "Synchronous/Messages"


This is due to pact-net using 

        [DllImport(DllName, EntryPoint = "pactffi_pact_handle_write_file")]
        public static extern int WritePactFile(uint pact, string directory, bool overwrite);

works correctly with

        [DllImport(DllName, EntryPoint = "pactffi_write_pact_file")]
        public static extern int WritePactFileForPort(int port, string directory, bool overwrite);

2. Provider verification not working with https