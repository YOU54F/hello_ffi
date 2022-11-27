#!/usr/bin/perl
use warnings;
print("Hello, from Perl!\n");

$ext = (("$^O" eq "darwin") eq 1 ? '.dylib' : (("$^O" eq "windows") eq 1 ? '.dll' : '.so'));
print("$ext\n");
use FFI::Platypus;;
 my $ffi = FFI::Platypus->new(
  api => 2,
  lib => "libpact_ffi$ext",
);


$ffi->attach('pactffi_version', [] => 'string');
$ffi->attach('pactffi_logger_init', [] => 'void');
$ffi->attach('pactffi_logger_attach_sink', ['string','int'] => 'int');
$ffi->attach('pactffi_logger_apply', [] => 'void');
$ffi->attach('pactffi_log_message', ['string','string','string'] => 'void');

my $version = pactffi_version();

pactffi_logger_init();
pactffi_logger_attach_sink('stdout',3);
pactffi_logger_apply();
pactffi_log_message('pact-perl-ffi', 'INFO', "hello from ffi version: $version");

$ffi->attach('pactffi_create_mock_server', ['string','string','int'] => 'int');
use JSON;;
my $pact = "{\"consumer\":{\"name\":\"pact-perl-ffi\"},\"interactions\":[{\"description\":\"a retrieve Mallory request\",\"request\":{\"method\":\"GET\",\"path\":\"/mallory\",\"query\":\"name=ron&status=good\"},\"response\":{\"body\":\"That is some good Mallory.\",\"headers\":{\"Content-Type\":\"text/html\"},\"status\":200}}],\"metadata\":{\"pact-perl\":{\"ffi\":\"0.3.15\",\"version\":\"1.0.0\"},\"pactRust\":{\"mockserver\":\"0.9.5\",\"models\":\"1.0.0\"},\"pactSpecification\":{\"version\":\"1.0.0\"}},\"provider\":{\"name\":\"Alice Service\"}}\n";
my $mock_server_port = pactffi_create_mock_server($pact,'127.0.0.1:4432',0);
pactffi_log_message('pact-perl-ffi', 'INFO', "mock_server_port: $mock_server_port");

$ffi->attach('pactffi_mock_server_matched', ['int'] => 'bool');
my $matched = pactffi_mock_server_matched($mock_server_port);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_mock_server_matched: $matched");

my $PACT_FILE_DIR = './pacts';
$ffi->attach('pactffi_write_pact_file', ['int','string','bool'] => 'bool');
my $res_write_pact = pactffi_write_pact_file($mock_server_port, $PACT_FILE_DIR, 0);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_write_pact_file: $res_write_pact");

$ffi->attach('pactffi_cleanup_mock_server', ['int'] => 'int');
my $pactffi_cleanup_mock_server_result = pactffi_cleanup_mock_server($mock_server_port);
pactffi_log_message('pact-perl-ffi', 'INFO', "pactffi_cleanup_mock_server: $pactffi_cleanup_mock_server_result");