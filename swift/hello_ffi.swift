#!/usr/bin/swift -import-objc-header pact.h -L${PWD} -lpact_ffi
import Foundation

let app_name: String = "pact-swift-ffi"
let version: String? = String(validatingUTF8: pactffi_version())
// print("Hello from Pact Swift FFI: \(version!)")

// Setup Loggers
pactffi_logger_init()
pactffi_logger_attach_sink("stdout", LevelFilter_Info)
pactffi_logger_apply()
pactffi_log_message(app_name, "INFO", "hello from ffi version: \(version!)")