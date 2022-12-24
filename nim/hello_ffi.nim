import strformat
when defined(Windows):
  const libName* = "pact_ffi.dll"
elif defined(Linux):
  const libName* = "libpact_ffi.so"
elif defined(MacOsX):
  const libName* = "libpact_ffi.dylib"

proc pactFfiVersion(): cstring {.importc: "pactffi_version", dynlib: libName.}
proc pactffiLoggerInit*() {.importc: "pactffi_logger_init", dynlib: libName.}
type
  LevelFilter* {.size: sizeof(cint).} = enum
    LevelFilterOff, LevelFilterError, LevelFilterWarn, LevelFilterInfo,
    LevelFilterDebug, LevelFilterTrace
proc pactffiLoggerAttachSink*(sinkSpecifier: cstring; levelFilter: LevelFilter): cint {.
    importc: "pactffi_logger_attach_sink", dynlib: libName.}
proc pactffiLoggerApply*(): cint {.importc: "pactffi_logger_apply", dynlib: libName.}
proc pactffiLogMessage*(source: cstring; logLevel: cstring; message: cstring) {.
    importc: "pactffi_log_message", dynlib: libName.}

pactffiLoggerInit()
discard pactffiLoggerAttachSink("stdout", LevelFilter_Debug)
discard pactffiLoggerApply()
pactffiLogMessage("pact-nim","INFO",cstring(fmt"hello from ffi version: {pactFFiVersion()}"))
