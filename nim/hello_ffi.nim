import strformat
when defined(Windows):
  const libName* = "pact_ffi.dll"
elif defined(Linux):
  const libName* = "libpact_ffi.so"
elif defined(MacOsX):
  const libName* = "libpact_ffi.dylib"

proc pactFfiVersion(): cstring {.importc: "pactffi_version", dynlib: libName.}

echo fmt"Hello from Pact Nim: {pactFfiVersion()}"