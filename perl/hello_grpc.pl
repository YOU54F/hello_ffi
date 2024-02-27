#!/usr/bin/perl
use warnings;
use Cwd qw();

print("Hello, from Perl!\n");

print("$^O\n");
$library = (("$^O" eq "darwin") eq 1 ? 'libpact_ffi.dylib' : (("$^O" eq "MSWin32") eq 1 ? 'pact_ffi.dll' : 'libpact_ffi.so'));
use FFI::Platypus;;
 my $ffi = FFI::Platypus->new(
  api => 2,
  lib => $library,
);

## Setup Loggers

$ffi->attach('pactffi_version', [] => 'string');
$ffi->attach('pactffi_logger_init', []);
$ffi->attach('pactffi_logger_attach_sink', ['string','int'] => 'int');
$ffi->attach('pactffi_logger_apply', []);
$ffi->attach('pactffi_log_message', ['string','string','string']);

my $version = pactffi_version();

pactffi_logger_init();
pactffi_logger_attach_sink('stdout',3);
pactffi_logger_apply();
pactffi_log_message('pact-perl-ffi', 'INFO', "hello from ffi version: $version");

use JSON;;
my $path = Cwd::cwd();
print "$path\n";
my $contents = "{\"pact:proto\":\"$path/proto/area_calculator.proto\",\"pact:proto-service\":\"Calculator/calculateOne\",\"pact:content-type\":\"application/protobuf\",\"request\":{\"rectangle\":{\"length\":\"matching(number, 3)\",\"width\":\"matching(number, 4)\"}},\"response\":{\"value\":[\"matching(number, 12)\"]}}\n";

## Setup pact for testing
$ffi->type( 'opaque' => 'pact' );
$ffi->attach('pactffi_new_pact', ['string','string'] => 'pact');
my $pact = pactffi_new_pact('grpc-consumer-perl', 'area-calculator-provider');
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_new_pact: $pact");
$ffi->attach('pactffi_with_pact_metadata', ['string','string','string','string'] => 'int');
pactffi_with_pact_metadata($pact, 'pact-perl', 'ffi', $version);
$ffi->type( 'opaque' => 'message_pact' );
$ffi->attach('pactffi_new_sync_message_interaction', ['pact','string'] => 'message_pact');
my $message_pact = pactffi_new_sync_message_interaction($pact, 'A gRPC calculateOne request');
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_new_sync_message_interaction: $message_pact");
$ffi->attach('pactffi_with_specification', ['pact','int'] => 'int');
pactffi_with_specification($pact, 5);

# Start mock server
pactffi_log_message('pact-perl-ffi', 'INFO', "using plugin");
$ffi->attach('pactffi_using_plugin', ['pact','string','string'] => 'int');
pactffi_using_plugin($pact, 'protobuf', '0.3.14');
pactffi_log_message('pact-perl-ffi', 'INFO', "got plugin");
pactffi_log_message('pact-perl-ffi', 'INFO', "setting interaction contents");
$ffi->attach('pactffi_interaction_contents', ['message_pact','int','string','string'] => 'int');
pactffi_interaction_contents($message_pact, 0, 'application/grpc', $contents);
pactffi_log_message('pact-perl-ffi', 'INFO', "set interaction contents");

pactffi_log_message('pact-perl-ffi', 'INFO', "setting pactffi_create_mock_server_for_transport");
$ffi->attach('pactffi_create_mock_server_for_transport', ['pact','string','int','string','string'] => 'int');
my $mock_server_port = pactffi_create_mock_server_for_transport($pact,'0.0.0.0',0,'grpc',0);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_create_mock_server_for_transport: $mock_server_port");


# check results and write pact

$ffi->attach('pactffi_mock_server_matched', ['int'] => 'bool');
my $matched = pactffi_mock_server_matched($mock_server_port);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_mock_server_matched: $matched");

$ffi->attach('pactffi_mock_server_mismatches', ['int'] => 'string');
my $mismatches = pactffi_mock_server_mismatches($mock_server_port);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_mock_server_mismatches: $mismatches");

my $PACT_FILE_DIR = './pacts';
$ffi->attach('pactffi_write_pact_file', ['int','string','int'] => 'int');
my $res_write_pact = pactffi_write_pact_file($mock_server_port, $PACT_FILE_DIR, 0);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_write_pact_file: $res_write_pact");

$ffi->attach('pactffi_cleanup_mock_server', ['int'] => 'bool');
my $pactffi_cleanup_mock_server_result = pactffi_cleanup_mock_server($mock_server_port);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_cleanup_mock_server: $pactffi_cleanup_mock_server_result");

$ffi->attach('pactffi_cleanup_plugins', ['pact']);
pactffi_cleanup_plugins($pact);
