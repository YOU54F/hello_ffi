require 'ffi'
require_relative '../detect_os'

module PactRubyFfi
    extend FFI::Library
    ffi_lib DetectOS.get_bin_path
  
    # Consumer
    attach_function :pactffi_init, [:string], :pointer
    attach_function :pactffi_init_with_log_level, [:string], :pointer
    attach_function :pactffi_new_pact, %i[string string], :pointer
    attach_function :pactffi_with_specification, %i[pointer int], :bool
    attach_function :pactffi_with_pact_metadata, %i[pointer string string string], :bool
    attach_function :pactffi_new_interaction, %i[pointer string], :pointer
    attach_function :pactffi_upon_receiving, %i[pointer string], :bool
    attach_function :pactffi_given, %i[pointer string], :bool
    attach_function :pactffi_with_request, %i[pointer string string], :bool
    attach_function :pactffi_with_header, %i[pointer int string int string], :bool
    attach_function :pactffi_with_body, %i[pointer int string string], :bool
    attach_function :pactffi_with_binary_file, %i[pointer int string pointer uint], :bool
    attach_function :pactffi_response_status, %i[pointer int], :bool
    attach_function :pactffi_create_mock_server, %i[pointer string], :int
    attach_function :pactffi_create_mock_server_for_pact, %i[pointer string bool], :int
    attach_function :pactffi_mock_server_matched, [:int], :bool
    attach_function :pactffi_mock_server_mismatches, [:int], :string
    attach_function :pactffi_cleanup_mock_server, [:int], :bool
    attach_function :pactffi_version, [], :string
    attach_function :pactffi_write_pact_file, %i[int string bool], :int
    attach_function :pactffi_write_message_pact_file, %i[pointer string bool], :int
    # Message Pact Consumer
    attach_function :pactffi_new_message_pact, %i[string string], :pointer
    attach_function :pactffi_new_message, %i[pointer string], :pointer
    attach_function :pactffi_message_expects_to_receive, %i[pointer string], :pointer
    attach_function :pactffi_message_given, %i[pointer string], :pointer
    # update me
    attach_function :pactffi_message_with_contents, %i[pointer string pointer uint], :bool
    attach_function :pactffi_message_reify, %i[pointer], :string
    # attach_function :pactffi_message_get_contents, %i[pointer], :string
  
    # Verifier
    attach_function :pactffi_verifier_new_for_application, %i[string string], :pointer
    attach_function :pactffi_verifier_set_provider_info, %i[pointer string string string int string], :void
    attach_function :pactffi_verifier_set_filter_info, %i[pointer string string bool], :void
    attach_function :pactffi_verifier_set_provider_state, %i[pointer string bool bool], :void
    attach_function :pactffi_verifier_set_verification_options, %i[pointer bool int], :void
    # likely wrong array
    attach_function :pactffi_verifier_set_publish_options, %i[pointer string string string int string], :void
    attach_function :pactffi_verifier_set_consumer_filters, %i[pointer pointer int], :void
    attach_function :pactffi_verifier_add_custom_header, %i[pointer string string], :void
    attach_function :pactffi_verifier_add_file_source, %i[pointer string], :void
    attach_function :pactffi_verifier_add_directory_source, %i[pointer string], :void
    attach_function :pactffi_verifier_url_source,
                    %i[pointer string string string string bool string pointer string pointer pointer], :void
    # this is very likely wrong
    callback :pactffi_verifier_execute_callback, %i[string int], :void
    attach_function :pactffi_verifier_execute, %i[pointer], :int
    attach_function :pactffi_verifier_shutdown, %i[pointer], :int
    attach_function :pactffi_verifier_logs, %i[pointer], :string
  
    ### log https://docs.rs/pact_ffi/latest/pact_ffi/log/index.html
    # Fetch the in-memory logger buffer contents. This will only have any contents if the buffer sink has been configured to log to. The contents will be allocated on the heap and will need to be freed with pactffi_string_delete.
    attach_function :pactffi_fetch_log_buffer, %i[string], :string
    # # 	Convenience function to direct all logging to a task local memory buffer.
    # attach_function :pactffi_log_to_buffer, %i[],:
    # # 	Convenience function to direct all logging to a file.
    attach_function :pactffi_log_to_file, %i[string int], :int
    # # 	Convenience function to direct all logging to stderr.
    # attach_function :pactffi_log_to_stderr, %i[],:
    attach_function :pactffi_log_to_stderr, %i[int], :int
    # # 	Convenience function to direct all logging to stdout.
    attach_function :pactffi_log_to_stdout, %i[int], :int
    # # 	Apply the previously configured sinks and levels to the program. If no sinks have been setup, will set the log level to info and the target to standard out.
    attach_function :pactffi_logger_apply, [], :int
    # # 	Attach an additional sink to the thread-local logger.
    attach_function :pactffi_logger_attach_sink, %i[string int], :string
    # # 	Initialize the FFI logger with no sinks.
    attach_function :pactffi_logger_init, [], :void
    attach_function :pactffi_log_message, %i[string string string], :int
  
    # Plugins
    ### plugins	The plugins module provides exported functions using C bindings for using plugins with Pact tests.
    #	Add a plugin to be used by the test. The plugin needs to be installed correctly for this function to work.
    attach_function :pactffi_using_plugin, %i[pointer string string], :int
    attach_function :pactffi_new_async_message, %i[pointer string], :pointer
    attach_function :pactffi_new_message_interaction, %i[pointer string], :pointer
    attach_function :pactffi_new_sync_message_interaction, %i[pointer string], :pointer
    # # 	Create a mock server for the provided Pact handle and transport. If the transport is not provided (it is a NULL pointer or an empty string), will default to an HTTP transport. The address is the interface bind to, and will default to the loopback adapter if not specified. Specifying a value of zero for the port will result in the operating system allocating the port.
    attach_function :pactffi_create_mock_server_for_transport, %i[pointer string uint string string], :int
    #	Decrement the access count on any plugins that are loaded for the Pact. This will shutdown any plugins that are no longer required (access count is zero).
    attach_function :pactffi_cleanup_plugins, %i[pointer], :void
    #	Setup the interaction part using a plugin. The contents is a JSON string that will be passed on to the plugin to configure the interaction part. Refer to the plugin documentation on the format of the JSON contents.
    attach_function :pactffi_interaction_contents, %i[pointer int string string], :int
end

p PactRubyFfi.pactffi_version
PactRubyFfi.pactffi_logger_init
PactRubyFfi.pactffi_logger_attach_sink('stdout', 5)
PactRubyFfi.pactffi_logger_attach_sink('stderr', 5)
PactRubyFfi.pactffi_logger_apply
PactRubyFfi.pactffi_log_message('pact-ruby-ffi', 'INFO', "hello from ffi version: #{PactRubyFfi.pactffi_version}")