import { ensureFile } from "https://deno.land/std/fs/ensure_file.ts";
import { gunzipFile } from "https://deno.land/x/compress@v0.4.4/gzip/mod.ts";

async function downloadFile(src: string, dest: string) {
  if (!(src.startsWith("http://") || src.startsWith("https://"))) {
    throw new TypeError("URL must start with be http:// or https://");
  }
  const resp = await fetch(src);
  if (!resp.ok) {
    throw new Deno.errors.BadResource(
      `Request failed with status ${resp.status}`
    );
  } else if (!resp.body) {
    throw new Deno.errors.UnexpectedEof(
      `The download url ${src} doesn't contain a file to download`
    );
  } else if (resp.status === 404) {
    throw new Deno.errors.NotFound(
      `The requested url "${src}" could not be found`
    );
  }

  await ensureFile(dest);
  const file = await Deno.open(dest, { truncate: true, write: true });
  await resp.body.pipeTo(file.writable);
}

export const detectFfiDownloadForPlatform = (ffiVersion = "v0.3.14") => {
  const platform = Deno.build.os + "-" + Deno.build.arch;
  console.log(platform);
  let filename;
  switch (platform) {
    case "darwin-aarch64":
      filename = "libpact_ffi-osx-aarch64-apple-darwin.dylib.gz";
      break;
    case "darwin-x86_64":
      filename = "libpact_ffi-osx-x86_64.dylib.gz";
      break;
    case "linux-aarch64":
      filename = "libpact_ffi-linux-aarch64.so.gz";
      break;
    case "linux-x86_64":
      filename = "libpact_ffi-linux-x86_64.so.gz";
      break;
    default:
      if (platform.includes("windows")) {
        filename = "pact_ffi-windows-x86_64.dll.gz";
        break;
      }
      `We do not have a binary for your platform ${platform}`;
      break;
  }
  const ffiLibDownloadLocation = `https://github.com/pact-foundation/pact-reference/releases/download/libpact_ffi-${ffiVersion}/${filename}`;
  const ffiHeaderDownloadLocation = `https://github.com/pact-foundation/pact-reference/releases/download/libpact_ffi-${ffiVersion}/pact.h`;
  console.log(ffiLibDownloadLocation);
  return { ffiLibDownloadLocation, ffiHeaderDownloadLocation };
};



export const downloadFfiForPlatform = async (ffiVersion = "v0.3.14") => {
  const locs = detectFfiDownloadForPlatform(ffiVersion);
  const libraryFilename =
    Deno.build.os === "darwin"
      ? "libpact_ffi.dylib"
      : Deno.build.os === "windows"
      ? "pact_ffi.dll"
      : "libpact_ffi.so";
  const exists = await checkIfFfiExists(libraryFilename);
  if (!exists.pactFfiLib) {
    console.log('downloading',locs.ffiLibDownloadLocation)
    await downloadFile(locs.ffiLibDownloadLocation, "libpact_ffi.gz");
    console.log('extracting', libraryFilename)
    await gunzipFile("libpact_ffi.gz", libraryFilename);
    Deno.removeSync("libpact_ffi.gz");
  } else{
    console.log('pact ffi library exists')
  }
  if (!exists.pactFfiHeaders) {
    exists.pactFfiHeaders
      ? console.log("ffi header file exists")
      : await downloadFile(locs.ffiHeaderDownloadLocation, "pact.h");
  } else{
    console.log('pact header files exist')
  }
};

const checkIfFfiExists = async (libraryFilename:string) => {
  let pactFfiLib;
  let pactFfiHeaders;
  try {
     pactFfiLib=await Deno.stat(libraryFilename);
  } catch(e) {
    if(e instanceof Deno.errors.NotFound)
      console.error('ffi lib does not exist, will download', libraryFilename);
  }  
  try {
    pactFfiHeaders=await Deno.stat('pact.h');
  } catch(e) {
    if(e instanceof Deno.errors.NotFound)
    console.error('ffi header file does not exist, will download');
  }
  
  return { pactFfiLib, pactFfiHeaders };
};

function helloFfi() {
  const textEncoder = new TextEncoder();

  const encode = (text: string) => {
    const buff = textEncoder.encode(text + "\0");
    return buff;
  };

  const decode = (result: any) => {
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
}


await downloadFfiForPlatform()
helloFfi()