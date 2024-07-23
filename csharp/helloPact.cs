using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace PInvokeTest
{
    class Program
    
    {
        static void Main(string[] args)
        {
            Console.OutputEncoding = System.Text.Encoding.UTF8;
            var version = Marshal.PtrToStringAnsi(pactffi_version());
            pactffi_logger_init();
            pactffi_logger_attach_sink("stdout", 3);
            pactffi_logger_apply();
            pactffi_log_message("pact-csharp", "info", $"hello from ffi version: {version}");
            
            var host = "0.0.0.0";
            var pact = NewPact("foo","bar");
            var interaction = NewSyncMessageInteraction(pact,"a request to a plugin");
            WithSpecification(pact,PactSpecification.V4);
            var content = @"{
                    ""pact:proto"": ""/Users/saf/dev/you54f/hello_ffi/proto/area_calculator.proto"",
                    ""pact:proto-service"": ""Calculator/calculateOne"",
                    ""pact:content-type"": ""application/protobuf"",
                    ""request"": {
                    ""rectangle"": {
                        ""length"": ""matching(number, 3)"",
                        ""width"": ""matching(number, 4)""
                    }
                    },
                    ""response"": {
                    ""value"": [""matching(number, 12)""]
                    }
                }";
            PluginAdd(pact,"protobuf","0.4.0");
            PluginInteractionContents(interaction,0,"application/grpc",content);

            var port = CreateMockServerForTransport(pact,host,0,"grpc",null);
            Console.WriteLine("Port: " + port);

            var matched = MockServerMatched(port);
            Console.WriteLine("Matched: " + matched);

            var mismatches = MockServerMismatches(port);
            Console.WriteLine("Mismatches: " + Marshal.PtrToStringAnsi(mismatches));

            PluginCleanup(pact);
            WritePactFile(pact, null, false);
        }

        const string DllName = "pact_ffi";

        internal enum InteractionPart
        {
            Request = 0,
            Response = 1
        }
        internal enum PactSpecification
        {
            Unknown = 0,
            V1 = 1,
            V1_1 = 2,
            V2 = 3,
            V3 = 4,
            V4 = 5
        }

        [DllImport(DllName)]
        private static extern IntPtr pactffi_version();
        [DllImport(DllName)]
        private static extern void pactffi_logger_init();
        [DllImport(DllName)]
        private static extern Int32 pactffi_logger_attach_sink( string sinkSpecifier, Int32 levelFilter);
        [DllImport(DllName)]
        private static extern void pactffi_logger_apply();
        [DllImport(DllName)]
        private static extern void pactffi_log_message(string source,string logLevel,string message);


        [DllImport(DllName, EntryPoint = "pactffi_new_pact")]
        public static extern uint NewPact(string consumerName, string providerName);
        [DllImport(DllName, EntryPoint = "pactffi_with_specification")]
        public static extern bool WithSpecification(uint pact, PactSpecification version);
                [DllImport(DllName, EntryPoint = "pactffi_new_interaction")]
        public static extern uint NewInteraction(uint pact, string description);
        [DllImport(DllName, EntryPoint = "pactffi_new_sync_message_interaction")]
        public static extern uint NewSyncMessageInteraction(uint pact, string description);

        [DllImport(DllName, EntryPoint = "pactffi_create_mock_server_for_transport")]
        public static extern int CreateMockServerForTransport(uint pact, string addrStr, ushort port, string transport, string transportConfig);
        [DllImport(DllName, EntryPoint = "pactffi_mock_server_mismatches")]
        public static extern IntPtr MockServerMismatches(int mockServerPort);
        
        [DllImport(DllName, EntryPoint = "pactffi_mock_server_matched")]
        public static extern bool MockServerMatched(int mockServerPort);
        
        [DllImport(DllName, EntryPoint = "pactffi_pact_handle_write_file")]
        public static extern int WritePactFile(uint pact, string directory, bool overwrite);

        // Plugins
        [DllImport(DllName, EntryPoint = "pactffi_interaction_contents")]
        public static extern uint PluginInteractionContents(uint interaction, InteractionPart part, string contentType, string body);
        [DllImport(DllName, EntryPoint = "pactffi_using_plugin")]
        public static extern uint PluginAdd(uint pact, string name, string version);
        [DllImport(DllName, EntryPoint = "pactffi_cleanup_plugins")]
        public static extern void PluginCleanup(uint pact);

    }
}