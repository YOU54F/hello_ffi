import {DenoPact} from '../../deno-pact.ts'
import { getShapeMessage } from "../area_calculator/areaCalculatorClient.ts";

const test = async () => {
  // Setup
  const version = DenoPact.getFFIVersion();
  DenoPact.setupLoggers(4);

  // Arrange

  const pact_contents = {
    "pact:proto": `${Deno.cwd()}/proto/area_calculator.proto`,
    "pact:proto-service": "Calculator/calculateOne",
    "pact:content-type": "application/protobuf",
    request: {
      rectangle: { length: "matching(number, 3)", width: "matching(number, 4)" }
    },
    response: { value: ["matching(number, 12)"] }
  };

  const pact = DenoPact.newPact("consumer-test", "provider-test");
  DenoPact.addMetaDataToPact(pact, version);
  const message_pact = DenoPact.newSyncMessageInteraction(
    pact,
    "A gRPC calculateOne request"
  );
  DenoPact.setPactSpecification(pact, 5);
  DenoPact.usingPactPlugin(pact, "denopactplugin");
  DenoPact.usingPactPlugin(pact, "protobuf");
  DenoPact.withInteractionContents(message_pact, 0, "application/protobuf", pact_contents);
  // # Start mock server
  const mock_server_port = DenoPact.createMockServerForTransport(pact, "grpc");
  DenoPact.logMessage(
    "pactffi_create_mock_server_for_transport: running on port " +
      mock_server_port
  );

  // Act
  const results = await getShapeMessage(mock_server_port);
  console.log(results);

  // Assert

  const matches = DenoPact.checkMatches(mock_server_port);
  if (!matches) {
    console.log("✅ tests passed 👌");
    DenoPact.writePactFiles(mock_server_port, "./pacts");
  }

  // Cleanup

  DenoPact.cleanupMockServer(mock_server_port);
  DenoPact.cleanupPlugins(pact);
  console.log("🧹 Cleaned up Pact processes");
  if (matches) {
    console.log("🚨 tests failed, check out the errors below 👇");
    console.log(JSON.stringify(JSON.parse(matches), null, "\t"));
    Deno.exit(1)
  }
};

test()