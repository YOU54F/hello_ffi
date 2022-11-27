#!/usr/bin/perl
use warnings;
use Config;
print("Hello, from Perl!\n");

print("$^O\n");
$library = (("$^O" eq "darwin") eq 1 ? 'libpact_ffi.dylib' : (("$^O" eq "windows") eq 1 ? 'pact_ffi.dll' : 'libpact_ffi.so'));
use FFI::Platypus;;
 my $ffi = FFI::Platypus->new(
  api => 2,
  lib => $library,
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