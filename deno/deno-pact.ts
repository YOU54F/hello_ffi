// ffi.ts
// https://medium.com/deno-the-complete-reference/calling-c-functions-from-deno-part-2-pass-buffers-ad168a3b6cc7
// https://github.com/denoland/deno/issues/15289
const libName = Deno.build.os === "darwin"
? "libpact_ffi.dylib"
: Deno.build.os === "windows"
? "pact_ffi.dll"
: "libpact_ffi.so";

const dylib = Deno.dlopen(libName, {
  pactffi_version: { parameters: [], result: "pointer" },
  pactffi_logger_init: { parameters: [], result: "void" },
  pactffi_logger_attach_sink: { parameters: ["buffer", "i32"], result: "i32" },
  pactffi_logger_apply: { parameters: [], result: "void" },
  pactffi_log_message: {
    parameters: ["buffer", "buffer", "buffer"],
    result: "void"
  },
  pactffi_new_pact: { parameters: ["buffer", "buffer"], result: "pointer" },
  pactffi_with_pact_metadata: {
    parameters: ["pointer", "buffer", "buffer", "buffer"],
    result: "i32"
  },
  pactffi_new_sync_message_interaction: {
    parameters: ["pointer", "buffer"],
    result: "pointer"
  },
  pactffi_with_specification: { parameters: ["pointer", "i32"], result: "i32" },
  pactffi_using_plugin: {
    parameters: ["pointer", "buffer", "buffer"],
    result: "i32"
  },
  pactffi_interaction_contents: {
    parameters: ["pointer", "i32", "buffer", "buffer"],
    result: "i32"
  },
  pactffi_create_mock_server: {
    parameters: ["buffer", "buffer", "i32"],
    result: "i32"
  },
  pactffi_create_mock_server_for_transport: {
    parameters: ["pointer", "buffer", "i32", "buffer", "pointer"],
    result: "i32"
  },
  pactffi_mock_server_matched: { parameters: ["i32"], result: "i32" },
  pactffi_mock_server_mismatches: { parameters: ["i32"], result: "pointer" },
  pactffi_write_pact_file: {
    parameters: ["i32", "buffer", "i32"],
    result: "i32"
  },
  pactffi_cleanup_mock_server: { parameters: ["i32"], result: "i32" },
  pactffi_cleanup_plugins: { parameters: ["pointer"], result: "void" }
} as const);

const PACT_FILE_DIR = "./pacts";
interface DenoPactService {
  ffi: typeof dylib.symbols;
  textEncoder: TextEncoder;
  encode(text: string): Uint8Array;
  decode(result: Deno.PointerValue): string;
  setupLoggers(level?: number): void;
  logMessage(msg: string, level?: string, app?: string): void;
  getFFIVersion(): string;
  checkMatches(mock_server_port: number): string | undefined;
  writePactFiles(mock_server_port: number, pact_dir?: string): number;
  createMockServer(pact: any, hostname?: string, port?: string): number;
  cleanupMockServer(mock_server_port: number): number;
  cleanupPlugins(pact: Deno.PointerValue): void;
  newPact(consumer_name: string, provider_name: string): Deno.PointerValue;
  addMetaDataToPact(
    pact: Deno.PointerValue,
    value: string,
    key?: string,
    app?: string
  ): void;
  newSyncMessageInteraction(
    pact: Deno.PointerValue,
    description: string
  ): Deno.PointerValue;
  setPactSpecification(pact: Deno.PointerValue, specifcation?: number): void;
  usingPactPlugin(
    pact: Deno.PointerValue,
    pluginName: string,
    pluginVersion?: string
  ): void;
  withInteractionContents(
    messagePact: Deno.PointerValue,
    interactionPart: 0 | 1,
    transportType: string,
    contents: any
  ): void;
  createMockServerForTransport(
    pact: Deno.PointerValue,
    transport: string,
    address?: string,
    port?: number,
    transportOptions?: 0 | any
  ): number;
}

export const DenoPact: DenoPactService = {
  ffi: dylib.symbols,
  textEncoder: new TextEncoder(),
  encode(text: string) {
    const buff = this.textEncoder.encode(text + "\0");
    return buff;
  },
  decode(result: Deno.PointerValue) {
    return new Deno.UnsafePointerView(result).getCString();
  },
  logMessage(msg: string, level = "INFO", app = "pact-deno-ffi") {
    this.ffi.pactffi_log_message(
      this.encode(app),
      this.encode(level),
      this.encode(msg)
    );
  },
  getFFIVersion() {
    return this.decode(this.ffi.pactffi_version());
  },
  setupLoggers(level = 3) {
    // ## Setup Loggers
    const version = this.getFFIVersion();
    this.ffi.pactffi_logger_init();
    this.ffi.pactffi_logger_attach_sink(this.encode("stdout"), level);
    this.ffi.pactffi_logger_apply();
    this.logMessage("hello from ffi version: " + version);
  },
  checkMatches(mock_server_port: number) {
    const matched = this.ffi.pactffi_mock_server_matched(mock_server_port);
    this.logMessage("pactffi_mock_server_matched: " + matched);

    if (matched === 0) {
      const mismatches =
        this.ffi.pactffi_mock_server_mismatches(mock_server_port);
      this.logMessage(
        "pactffi_mock_server_mismatches: " + this.decode(mismatches)
      );
      return this.decode(mismatches) as string;
    } else return;
  },
  writePactFiles(mock_server_port: number, pact_dir = PACT_FILE_DIR) {
    const res_write_pact = this.ffi.pactffi_write_pact_file(
      mock_server_port,
      this.encode(pact_dir),
      0
    );
    this.logMessage("pactffi_write_pact_file: " + res_write_pact);
    return res_write_pact;
  },
  createMockServer(pact: any, hostname = "127.0.0.1", port = "0") {
    const mock_server_port = this.ffi.pactffi_create_mock_server(
      this.encode(JSON.stringify(pact)),
      this.encode(hostname + ":" + port),
      0
    );
    this.ffi.pactffi_log_message(
      this.encode("pact-deno-ffi"),
      this.encode("INFO"),
      this.encode(
        "pactffi_create_mock_server: running on port " + mock_server_port
      )
    );
    return mock_server_port;
  },
  cleanupMockServer(mock_server_port: number) {
    const pactffi_cleanup_mock_server_result =
      this.ffi.pactffi_cleanup_mock_server(mock_server_port);
    this.logMessage(
      "pactffi_cleanup_mock_server: " + pactffi_cleanup_mock_server_result
    );
    return pactffi_cleanup_mock_server_result;
  },
  cleanupPlugins(pact: Deno.PointerValue) {
    this.ffi.pactffi_cleanup_plugins(pact);
  },
  newPact(consumer_name: string, provider_name: string) {
    return this.ffi.pactffi_new_pact(
      this.encode(consumer_name),
      this.encode(provider_name)
    );
  },
  addMetaDataToPact(
    pact: Deno.PointerValue,
    value: string,
    key = "ffi",
    app = "pact-deno"
  ) {
    this.ffi.pactffi_with_pact_metadata(
      pact,
      this.encode(app),
      this.encode(key),
      this.encode(value)
    );
  },
  newSyncMessageInteraction(pact: Deno.PointerValue, description: string) {
    return this.ffi.pactffi_new_sync_message_interaction(
      pact,
      this.encode(description)
    );
  },
  setPactSpecification(pact: Deno.PointerValue, specifcation = 5) {
    this.ffi.pactffi_with_specification(pact, specifcation);
  },
  usingPactPlugin(
    pact: Deno.PointerValue,
    pluginName: string,
    pluginVersion = ""
  ) {
    this.ffi.pactffi_using_plugin(
      pact,
      this.encode(pluginName),
      this.encode(pluginVersion)
    );
  },
  withInteractionContents(
    messagePact: Deno.PointerValue,
    interactionPart: 0 | 1,
    transportType: string,
    contents: any
  ) {
    this.ffi.pactffi_interaction_contents(
      messagePact,
      interactionPart,
      this.encode(transportType),
      this.encode(JSON.stringify(contents))
    );
  },
  createMockServerForTransport(
    pact: Deno.PointerValue,
    transport: string,
    address = "0.0.0.0",
    port = 0,
    transportOptions: 0 | any = 0
  ) {
    return this.ffi.pactffi_create_mock_server_for_transport(
      pact,
      this.encode(address),
      port,
      this.encode(transport),
      transportOptions
    );
  }
};