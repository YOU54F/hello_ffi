<?php

$library = php_uname('s') == 'Darwin' ? 'libpact_ffi.dylib' : (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN' ? 'pact_ffi.dll' : 'libpact_ffi.so');
$code = file_get_contents(__DIR__ . '/../pact.h');
$ffi = FFI::cdef($code, __DIR__ . '/../' . $library);

$ffi->pactffi_logger_init();
$ffi->pactffi_logger_attach_sink('stdout', 3);
$ffi->pactffi_logger_apply();
$ffi->pactffi_log_message('pact-php-ffi', 'INFO', 'hello from ffi version: ' . $ffi->pactffi_version());
