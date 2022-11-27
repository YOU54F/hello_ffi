// https://blog.devgenius.io/how-to-run-blazingly-fast-javascript-code-with-bun-rust-and-go-2e645cf579b5
import { dlopen, FFIType, suffix } from "ffi";
const path = `libpact_ffi.${suffix}`;
import process from 'process';
const {
  symbols: {
    pactffi_version,
    pactffi_logger_init,
    pactffi_logger_attach_sink,
    pactffi_logger_apply,
    pactffi_log_message,
    pactffi_new_pact,
    pactffi_with_pact_metadata,
    pactffi_new_sync_message_interaction,
    pactffi_with_specification,
    pactffi_using_plugin,
    pactffi_interaction_contents,
    pactffi_create_mock_server,
    pactffi_create_mock_server_for_transport,
    pactffi_mock_server_matched,
    pactffi_mock_server_mismatches,
    pactffi_write_pact_file,
    pactffi_cleanup_mock_server,
    pactffi_cleanup_plugins
  }
} = dlopen(path, {
  pactffi_version: {
    args: [],
    returns: FFIType.cstring
  },
  pactffi_logger_init: { args: [], returns: FFIType.void },
  pactffi_logger_attach_sink: {
    args: [FFIType.cstring, FFIType.i32],
    returns: FFIType.i32
  },
  pactffi_logger_apply: { args: [], returns: FFIType.i32 },
  pactffi_log_message: {
    args: [FFIType.cstring, FFIType.cstring, FFIType.cstring],
    returns: FFIType.void
  },
  pactffi_new_pact: {
    args: [FFIType.cstring, FFIType.cstring],
    returns: FFIType.pointer
  },
  pactffi_with_pact_metadata: {
    args: [FFIType.pointer, FFIType.cstring, FFIType.cstring, FFIType.cstring],
    returns: FFIType.bool
  },
  pactffi_new_sync_message_interaction: {
    args: [FFIType.pointer, FFIType.cstring],
    returns: FFIType.pointer
  },
  pactffi_with_specification: {
    args: [FFIType.pointer, FFIType.cstring],
    returns: FFIType.bool
  },
  pactffi_using_plugin: {
    args: [FFIType.pointer, FFIType.cstring, FFIType.cstring],
    returns: FFIType.u16
  },
  pactffi_interaction_contents: {
    args: [FFIType.pointer, FFIType.cstring, FFIType.cstring, FFIType.cstring],
    returns: FFIType.u16
  },
  pactffi_create_mock_server: {
    args: [FFIType.cstring, FFIType.cstring, FFIType.bool],
    returns: FFIType.i32
  },
  pactffi_create_mock_server_for_transport: {
    args: [
      FFIType.pointer,
      FFIType.cstring,
      FFIType.u16,
      FFIType.cstring,
      FFIType.cstring
    ],
    returns: FFIType.i32
  },
  pactffi_mock_server_matched: { args: [FFIType.i32], returns: FFIType.bool },
  pactffi_mock_server_mismatches: {
    args: [FFIType.i32],
    returns: FFIType.cstring
  },
  pactffi_write_pact_file: {
    args: [FFIType.i32, FFIType.cstring, FFIType.bool],
    returns: FFIType.i32
  },
  pactffi_cleanup_mock_server: { args: [FFIType.i32], returns: FFIType.bool },
  pactffi_cleanup_plugins: { args: [FFIType.pointer], returns: FFIType.void }
});

const s2b = (s: string) => Buffer.from(s + "\0", "utf-8");

const PactTestHttp = () => {

  console.log("🚀 Pact Mock Server Test - HTTP 🚀");

  const pact = {
    consumer: { name: "pact-bun-ffi" },
    interactions: [
      {
        description: "a retrieve Mallory request",
        request: {
          method: "GET",
          path: "/mallory",
          query: "name=ron&status=good"
        },
        response: {
          body: "That is some good Mallory.",
          headers: { "Content-Type": "text/html" },
          status: 200
        }
      }
    ],
    metadata: {
      "pact-bun": { ffi: pactffi_version(), version: "1.0.0" },
      pactRust: { mockserver: "0.9.5", models: "1.0.0" },
      pactSpecification: { version: "1.0.0" }
    },
    provider: { name: "Alice Service" }
  };
  const mock_server_port = pactffi_create_mock_server(
    s2b(JSON.stringify(pact)),
    s2b("127.0.0.1:4432"),
    false
  );
  pactffi_log_message(
    s2b("pact-bun-ffi"),
    s2b("INFO"),
    s2b(`mock_server_port: ${mock_server_port}`)
  );

  const matched = pactffi_mock_server_matched(mock_server_port);
  pactffi_log_message(
    s2b("pact-bun-ffi"),
    s2b("INFO"),
    s2b(`pactffi_mock_server_matched: ${matched}`)
  );

  if (!matched) {
    const mismatches = pactffi_mock_server_mismatches(mock_server_port);
    console.log("🚨 tests failed, check out the errors below 👇");
    console.log(JSON.stringify(JSON.parse(mismatches), null, "\t"));
  } else {
    console.log("✅ tests passed 👌");
    const PACT_FILE_DIR = "./pacts";
    const res_write_pact = pactffi_write_pact_file(
      mock_server_port,
      s2b(PACT_FILE_DIR),
      0
    );
    pactffi_log_message(
      s2b("pact-bun-ffi"),
      s2b("INFO"),
      s2b(`pactffi_write_pact_file: ${res_write_pact}`)
    );
  }

  const pactffi_cleanup_mock_server_result =
    pactffi_cleanup_mock_server(mock_server_port);
  pactffi_log_message(
    s2b("pact-bun-ffi"),
    s2b("INFO"),
    s2b(`pactffi_cleanup_mock_server: ${pactffi_cleanup_mock_server_result}`)
  );
  console.log("🧹 Cleaned up Pact processes");
};


const PactTestGrpc = async() => {
  console.log("🚀 Running Pact Protobuf Plugin Test with gRPC 🚀");
  const contents = {
    "pact:proto": `${process.cwd()}/../proto/area_calculator.proto`,
    "pact:proto-service": "Calculator/calculateOne",
    "pact:content-type": "application/protobuf",
    request: {
      rectangle: { length: "matching(number, 3)", width: "matching(number, 4)" }
    },
    response: { value: ["matching(number, 12)"] }
  };

  // Setup pact for testing

  const pact = pactffi_new_pact(
    s2b("grpc-consumer-bun"),
    s2b("area-calculator-provider")
  );
  console.log('pact')
  console.log(pact)
  pactffi_log_message(s2b("pact-bun-ffi"), s2b("INFO"), s2b(`pactffi_new_pact: ${pact})`));
  const pactffi_with_pact_metadata_res = pactffi_with_pact_metadata(pact, s2b("pact-bun"), s2b("ffi"), s2b(pactffi_version()));
  console.log('pactffi_with_pact_metadata_res')
  console.log(pactffi_with_pact_metadata_res)
  const message_pact = pactffi_new_sync_message_interaction(
    pact,
    s2b("A gRPC calculateOne request")
  );
  console.log('message_pact')
  console.log(message_pact)
  pactffi_log_message(
    s2b("pact-bun-ffi"),
    s2b("INFO"),
    s2b(`pactffi_new_sync_message_interaction: ${message_pact}`)
  );
  console.log('try pactffi_with_specification')
  const pactffi_with_specification_res = pactffi_with_specification(pact, s2b('PactSpecification_V4'));
  console.log('pactffi_with_specification_res')
  console.log(pactffi_with_specification_res)
  // Start mock server
  const pactffi_using_plugin_res = pactffi_using_plugin(pact, s2b("protobuf"), s2b("0.1.17"));
  console.log('pactffi_using_plugin_res')
  console.log(pactffi_using_plugin_res)
  const pactffi_interaction_contents_res = pactffi_interaction_contents(message_pact, s2b('InteractionPart_Request'), s2b("application/grpc"), s2b(JSON.stringify(contents)));
  console.log('pactffi_interaction_contents_res')
  console.log(pactffi_interaction_contents_res)
  const mock_server_port = pactffi_create_mock_server_for_transport(
    pact,
    s2b("0.0.0.0"),
    0,
    s2b("grpc"),
    0
  );
  console.log('mock_server_port')
  console.log(mock_server_port)
  pactffi_log_message(
    s2b("pact-bun-ffi"),
    s2b("INFO"),
    s2b(`pactffi_create_mock_server_for_transport: ${mock_server_port}`)
  );

  // This is where we would make our client request and assert the results

  // check results and write pact

  const matched = pactffi_mock_server_matched(mock_server_port);
  pactffi_log_message(
    s2b("pact-bun-ffi"),
    s2b("INFO"),
    s2b(`pactffi_mock_server_matched: ${matched}`)
  );

  if (!matched) {
    const mismatches = pactffi_mock_server_mismatches(mock_server_port);
    console.log("🚨 tests failed, check out the errors below 👇");
    console.log(JSON.stringify(JSON.parse(mismatches), null, "\t"));
  } else {
    console.log("✅ tests passed 👌");
    const PACT_FILE_DIR = "./pacts";
    const res_write_pact = pactffi_write_pact_file(
      mock_server_port,
      s2b(PACT_FILE_DIR),
      0
    );
    pactffi_log_message(
      s2b("pact-bun-ffi"),
      s2b("INFO"),
      s2b(`pactffi_write_pact_file: ${res_write_pact}`)
    );
  }

  const pactffi_cleanup_mock_server_result =
    pactffi_cleanup_mock_server(mock_server_port);
  pactffi_log_message(
    s2b("pact-bun-ffi"),
    s2b("INFO"),
    s2b(`pactffi_cleanup_mock_server: ${pactffi_cleanup_mock_server_result}`)
  );
  await pactffi_cleanup_plugins(pact);
  console.log("🧹 Cleaned up Pact processes");
};

console.log("Hello from Pact Bun FFI - Version", pactffi_version());

pactffi_logger_init();
pactffi_logger_attach_sink(s2b("stdout"), 3);
pactffi_logger_apply();
pactffi_log_message(
  s2b("pact-bun-ffi"),
  s2b("INFO"),
  s2b(`hello from ffi version: ${pactffi_version()}`)
);

PactTestHttp();

PactTestGrpc()
