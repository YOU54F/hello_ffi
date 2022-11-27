import { DenoPact } from "./deno-pact.ts";
const main = async () => {
  // Setup
  DenoPact.setupLoggers(3);

  // Arrange
  const pact = {
    consumer: { name: "pact-deno-ffi" },
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
      "pact-deno": { ffi: DenoPact.getFFIVersion(), version: "1.0.0" },
      pactRust: { mockserver: "0.9.5", models: "1.0.0" },
      pactSpecification: { version: "1.0.0" }
    },
    provider: { name: "Alice Service" }
  };

  const mock_server_port =  DenoPact.createMockServer(pact);

  // Act
  let resp = await fetch(
    "http://127.0.0.1:" + mock_server_port + "/mallory?name=ron&status=good"
  );
  console.log(resp.status); // 200
  console.log(resp.headers.get("Content-Type"));
  console.log(await resp.text());

  // Assert
  const matches =  DenoPact.checkMatches(mock_server_port);
  if (!matches) {
    console.log("✅ tests passed 👌");
    DenoPact.writePactFiles(mock_server_port, "./pacts");
  }

  // Cleanup
  DenoPact.cleanupMockServer(mock_server_port);
  if (matches) {
    console.log("🚨 tests failed, check out the errors below 👇");
    console.log(JSON.stringify(JSON.parse(matches), null, "\t"));
  }
};

console.log("🚀 Pact Mock Server Test - HTTP 🚀");
main();

export {};
