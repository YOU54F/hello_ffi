use NativeCall;
sub pactffi_version() returns Str is encoded('utf8') is native('pact_ffi') { * }
sub pactffi_logger_init() is native('pact_ffi') { * }
sub pactffi_logger_attach_sink(Str,int32) is native('pact_ffi') { * }
sub pactffi_logger_apply() is native('pact_ffi') { * }
sub pactffi_log_message(Str,Str,Str) is native('pact_ffi') { * }
my $version = pactffi_version();

pactffi_logger_init();
pactffi_logger_attach_sink('stdout',3);
pactffi_logger_apply();
pactffi_log_message('pact-raku-ffi', 'INFO', "hello from ffi version: $version");
