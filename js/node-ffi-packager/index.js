const pact = require("./libpact_ffi.h");

const version = pact.functions.pactffi_version();
pact.functions.pactffi_logger_init()
pact.functions.pactffi_logger_attach_sink('stdout',3)
pact.functions.pactffi_logger_apply()
pact.functions.pactffi_log_message("pact-js-ffi-generate-napi","info","Hello from ffi version: " + version)
