using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace PactFfi
{
    public class Pact
    
    {
        const string DllName = "pact_ffi";

        public enum InteractionPart
        {
            Request = 0,
            Response = 1
        }
        public enum PactSpecification
        {
            Unknown = 0,
            V1 = 1,
            V1_1 = 2,
            V2 = 3,
            V3 = 4,
            V4 = 5
        }

        [DllImport(DllName, EntryPoint = "pactffi_version")]
        public static extern IntPtr Version();
        [DllImport(DllName, EntryPoint = "pactffi_logger_init")]
        public static extern void LoggerInit();
        [DllImport(DllName, EntryPoint = "pactffi_logger_attach_sink")]
        public static extern Int32 LoggerAttachSink( string sinkSpecifier, Int32 levelFilter);
        [DllImport(DllName, EntryPoint = "pactffi_logger_apply")]
        public static extern void LoggerApply();
        [DllImport(DllName, EntryPoint = "pactffi_log_message")]
        public static extern void LogMessage(string source,string logLevel,string message);


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

        [DllImport(DllName, EntryPoint = "pactffi_cleanup_mock_server")]
        public static extern bool CleanupMockServer(int mockServerPort);
        
        [DllImport(DllName, EntryPoint = "pactffi_pact_handle_write_file")]
        public static extern int WritePactFile(uint pact, string directory, bool overwrite);

        [DllImport(DllName, EntryPoint = "pactffi_write_pact_file")]
        public static extern int WritePactFileForPort(int port, string directory, bool overwrite);

        // Plugins
        [DllImport(DllName, EntryPoint = "pactffi_interaction_contents")]
        public static extern uint PluginInteractionContents(uint interaction, InteractionPart part, string contentType, string body);
        [DllImport(DllName, EntryPoint = "pactffi_using_plugin")]
        public static extern uint PluginAdd(uint pact, string name, string version);
        [DllImport(DllName, EntryPoint = "pactffi_cleanup_plugins")]
        public static extern void PluginCleanup(uint pact);

    }
}