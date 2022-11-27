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


sub pactffi_create_mock_server(Str,Str,int32) returns int32 is native('pact_ffi') { * }
sub pactffi_cleanup_mock_server(int32) returns int32 is native('pact_ffi') { * }
sub pactffi_mock_server_matched(int32) returns bool is native('pact_ffi') { * }
sub pactffi_write_pact_file(int32,Str,bool) returns int32 is native('pact_ffi') { * }

my $pact = '{"consumer":{"name":"pact-raku-ffi"},"interactions":[{"description":"a retrieve Mallory request","request":{"method":"GET","path":"/mallory","query":"name=ron&status=good"},"response":{"body":"That is some good Mallory.","headers":{"Content-Type":"text/html"},"status":200}}],"metadata":{"pact-raku":{"ffi":"0.3.15","version":"1.0.0"},"pactRust":{"mockserver":"0.9.5","models":"1.0.0"},"pactSpecification":{"version":"1.0.0"}},"provider":{"name":"Alice Service"}}';

my $mock_server_port = pactffi_create_mock_server($pact,'127.0.0.1:4432',0);
pactffi_log_message('pact-perl-ffi', 'INFO', "mock_server_port: $mock_server_port");

my $matched = pactffi_mock_server_matched($mock_server_port);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_mock_server_matched: $matched");

my $PACT_FILE_DIR = './pacts';
my $res_write_pact = pactffi_write_pact_file($mock_server_port, $PACT_FILE_DIR, 0);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_write_pact_file: $res_write_pact");

my $pactffi_cleanup_mock_server_result = pactffi_cleanup_mock_server($mock_server_port);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_cleanup_mock_server: $pactffi_cleanup_mock_server_result");