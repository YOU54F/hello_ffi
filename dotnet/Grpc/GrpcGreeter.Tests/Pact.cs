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