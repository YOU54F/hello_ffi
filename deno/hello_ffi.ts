export const helloFfi = () => {
  const textEncoder = new TextEncoder();

  const encode = (text: string) => {
    const buff = textEncoder.encode(text + "\0");
    return buff;
  };

  const decode = (result: Deno.PointerValue) => {
    return new Deno.UnsafePointerView(result).getCString();
  };
    

  const libName = Deno.build.os === "darwin"
  ? "libpact_ffi.dylib"
  : Deno.build.os === "windows"
  ? "pact_ffi.dll"
  : "libpact_ffi.so";
  
  const dylib = Deno.dlopen(libName, {
    pactffi_version: { parameters: [], result: "pointer" },
    pactffi_logger_init: { parameters: [], result: "void" },
    pactffi_logger_attach_sink: {
      parameters: ["buffer", "i32"],
      result: "i32"
    },
    pactffi_logger_apply: { parameters: [], result: "void" },
    pactffi_log_message: {
      parameters: ["buffer", "buffer", "buffer"],
      result: "void"
    }
  } as const);
  const version = decode(dylib.symbols.pactffi_version());

  console.log("Hello from Pact Deno FFI - Version", version);

  // ## Setup Loggers

  dylib.symbols.pactffi_logger_init();
  dylib.symbols.pactffi_logger_attach_sink(encode("stdout"), 3);
  dylib.symbols.pactffi_logger_apply();
  dylib.symbols.pactffi_log_message(
    encode("pact-deno-ffi"),
    encode("INFO"),
    encode("hello from ffi version")
  );
};

helloFfi();
