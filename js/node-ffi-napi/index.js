const ffi = require("ffi-napi");

// name needs to be 
// libpact_ffi on linux/darwin
// pact_ffi on windows
const pact = ffi.Library("pact_ffi", {
  pactffi_version: ["string", []],
  pactffi_logger_init: ["void", []],
  pactffi_logger_attach_sink: ["int", ['string','int']],
  pactffi_logger_apply: ["void", []],
  pactffi_log_message: ["void", ['string','string','string']]
});
const version = pact.pactffi_version();
// console.log(version);
pact.pactffi_logger_init()
pact.pactffi_logger_attach_sink('stdout',3)
pact.pactffi_logger_apply()
pact.pactffi_log_message("pact-js-ffi-napi","info","Hello from ffi version: " + version)
