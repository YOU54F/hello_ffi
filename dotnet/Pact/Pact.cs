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

        [DllImport(DllName, EntryPoint = "pactffi_log_to_stdout")]
        public static extern Int32 LogToStdOut( Int32 levelFilter);

        [DllImport(DllName, EntryPoint = "pactffi_log_message")]
        public static extern void LogMessage(string source,string logLevel,string message);


        [DllImport(DllName, EntryPoint = "pactffi_new_pact")]
        public static extern uint NewPact(string consumerName, string providerName);
        [DllImport(DllName, EntryPoint = "pactffi_with_specification")]
        public static extern bool WithSpecification(uint pact, PactSpecification version);
        [DllImport(DllName, EntryPoint = "pactffi_new_interaction")]
        public static extern uint NewInteraction(uint pact, string description);

        [DllImport(DllName, EntryPoint = "pactffi_with_request")]
        public static extern bool WithRequest(uint interaction, string method, string path);

        [DllImport(DllName, EntryPoint = "pactffi_response_status")]
        public static extern bool ResponseStatus(uint interaction, ushort status);

        [DllImport(DllName, EntryPoint = "pactffi_given")]
        public static extern bool Given(uint interaction, string description);

        [DllImport(DllName, EntryPoint = "pactffi_new_sync_message_interaction")]
        public static extern uint NewSyncMessageInteraction(uint pact, string description);
        [DllImport(DllName, EntryPoint = "pactffi_new_message_interaction")]
        public static extern uint NewMessageInteraction(uint pact, string description);
        [DllImport(DllName, EntryPoint = "pactffi_pact_handle_get_message_iter")]
        public static extern uint PactHandleGetMessageIter(uint pact);

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
        [DllImport(DllName, EntryPoint = "pactffi_write_message_pact_file")]
        public static extern int WriteMessagePactFile(uint pact, string directory, bool overwrite);

        // Plugins
        [DllImport(DllName, EntryPoint = "pactffi_interaction_contents")]
        public static extern uint PluginInteractionContents(uint interaction, InteractionPart part, string contentType, string body);
        [DllImport(DllName, EntryPoint = "pactffi_using_plugin")]
        public static extern uint PluginAdd(uint pact, string name, string version);
        [DllImport(DllName, EntryPoint = "pactffi_cleanup_plugins")]
        public static extern void PluginCleanup(uint pact);

        // verifier

        [DllImport(DllName, EntryPoint = "pactffi_verifier_new_for_application")]
        public static extern IntPtr VerifierNewForApplication(string name, string version);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_shutdown")]
        public static extern void VerifierShutdown(IntPtr handle);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_set_provider_info")]
        public static extern void VerifierSetProviderInfo(IntPtr handle, string name, string scheme, string host, ushort port, string path);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_add_provider_transport")]
        public static extern void AddProviderTransport(IntPtr handle, string protocol, ushort port, string path, string scheme);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_set_filter_info")]
        public static extern void VerifierSetFilterInfo(IntPtr handle, string description, string state, byte noState);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_set_provider_state")]
        public static extern void VerifierSetProviderState(IntPtr handle, string url, byte teardown, byte body);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_set_verification_options")]
        public static extern void VerifierSetVerificationOptions(IntPtr handle,
                                                                 byte disableSslVerification,
                                                                 uint requestTimeout);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_set_publish_options")]
        public static extern void VerifierSetPublishOptions(IntPtr handle,
                                                            string providerVersion,
                                                            string buildUrl,
                                                            string[] providerTags,
                                                            ushort providerTagsLength,
                                                            string providerBranch);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_set_consumer_filters")]
        public static extern void VerifierSetConsumerFilters(IntPtr handle, string[] consumerFilters, ushort consumerFiltersLength);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_add_custom_header")]
        public static extern void AddCustomHeader(IntPtr handle, string name, string value);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_add_file_source")]
        public static extern void VerifierAddFileSource(IntPtr handle, string file);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_add_directory_source")]
        public static extern void VerifierAddDirectorySource(IntPtr handle, string directory);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_url_source")]
        public static extern void VerifierUrlSource(IntPtr handle, string url, string username, string password, string token);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_broker_source_with_selectors")]
        public static extern void VerifierBrokerSourceWithSelectors(IntPtr handle,
                                                                    string url,
                                                                    string username,
                                                                    string password,
                                                                    string token,
                                                                    byte enablePending,
                                                                    string includeWipPactsSince,
                                                                    string[] providerTags,
                                                                    ushort providerTagsLength,
                                                                    string providerBranch,
                                                                    string[] consumerVersionSelectors,
                                                                    ushort consumerVersionSelectorsLength,
                                                                    string[] consumerVersionTags,
                                                                    ushort consumerVersionTagsLength);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_execute")]
        public static extern int VerifierExecute(IntPtr handle);

        [DllImport(DllName, EntryPoint = "pactffi_verifier_logs")]
        public static extern IntPtr VerifierLogs(IntPtr handle);


        [DllImport(DllName, EntryPoint = "pactffi_verifier_output")]
        public static extern IntPtr VerifierOutput(IntPtr handle, byte stripAnsi);
    }
}