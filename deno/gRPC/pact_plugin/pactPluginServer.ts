import { GrpcServer } from "https://deno.land/x/grpc_basic@0.4.6/server.ts";
// import { common } from "./proto.d.ts";
import {
  InitPluginRequest,
  InitPluginResponse,
  PactPlugin,
  Catalogue,
  CompareContentsRequest,
  CompareContentsResponse,
  ConfigureInteractionRequest,
  ConfigureInteractionResponse,
  GenerateContentRequest,
  GenerateContentResponse,
  StartMockServerRequest,
  StartMockServerResponse,
  ShutdownMockServerRequest,
  ShutdownMockServerResponse,
  MockServerRequest,
  MockServerResults,
  VerificationPreparationRequest,
  VerificationPreparationResponse,
  VerifyInteractionRequest,
  VerifyInteractionResponse
} from "./plugin.d.ts";

const server = new GrpcServer();
const protoPath = new URL("../../../proto/plugin.proto", import.meta.url);
const protoFile = await Deno.readTextFile(protoPath);

const PactPluginService: PactPlugin = {
  async InitPlugin(request: InitPluginRequest):Promise<InitPluginResponse> {
    console.log("InitPlugin");
    console.log(request);
    const response = {
      catalogue: [
        {
          type: "CONTENT_MATCHER",
          key: "deno-plugin-matcher-example",
          values: { "content-types": "application/protobuf" }
        },
        {
          type: "CONTENT_GENERATOR",
          key: "deno-plugin-matcher-example",
          values: { "content-types": "application/protobuf" }
        },
        {
          type: "TRANSPORT",
          key: "grpc",
        }
      ]
    }
    console.log("InitPluginResponse");
    console.log(response);
    return response
  },

  async UpdateCatalogue(request) {
    console.log("UpdateCatalogue");
    console.log(request);
    return request;
  },
  
  async CompareContents(
    request: CompareContentsRequest
  ): Promise<CompareContentsResponse> {
    console.log("CompareContents");
    console.log(request);
    return {
      error: "string",
      typeMismatch: { expected: "expected", actual: "actual" },
      results: { mismatches: [] }
    };
  },

  async ConfigureInteraction(
    request
  ){
  //   request: ConfigureInteractionRequest
  // ): Promise<ConfigureInteractionResponse> {
    console.log("ConfigureInteraction");
    console.log(request);
    return {
      error: "error_string",
      interaction: []
      // pluginConfiguration: PluginConfiguration,
    };
  },

  async GenerateContent(
    request: GenerateContentRequest
  ): Promise<GenerateContentResponse> {
    console.log("GenerateContent");
    console.log(request);
    return { contents: {} };
  },

  async StartMockServer(
    request: StartMockServerRequest
  ): Promise<StartMockServerResponse> {
    console.log("StartMockServer");
    console.log(request);
    return {
      // error?: string;
      // details?: MockServerDetails;
    };
  },

  async ShutdownMockServer(
    request: ShutdownMockServerRequest
  ): Promise<ShutdownMockServerResponse> {
    console.log("ShutdownMockServer");
    console.log(request);
    return {
      ok: true,
      results: [{ path: "path", error: "error", mismatches: [] }]
    };
  },

  async GetMockServerResults(
    request: MockServerRequest
  ): Promise<MockServerResults> {
    console.log("GetMockServerResults");
    console.log(request);
    return {
      ok: true,
      results: [{ path: "path", error: "error", mismatches: [] }]
    };
  },

  async PrepareInteractionForVerification(
    request: VerificationPreparationRequest
  ): Promise<VerificationPreparationResponse> {
    console.log("PrepareInteractionForVerification");
    console.log(request);
    return {
      error: "error",
      interactionData: { body: {}, metadata: {} }
    };
  },

  async VerifyInteraction(
    request: VerifyInteractionRequest
  ): Promise<VerifyInteractionResponse> {
    console.log("VerifyInteraction");
    console.log(request);
    return {
      error: "error",
      result: {
        success: true,
        // responseData?: InteractionData;
        // mismatches?: VerificationResultItem[];
        output: ["woop", "woop", "from", "deno"]
      }
    };
  }
};

server.addService<PactPlugin>(protoFile, { ...PactPluginService });


const main = async (port = 50051) => {
  console.log(`Deno Pact Plugin`);
  console.log(JSON.stringify({ port, serverKey: crypto.randomUUID() }));
  for await (const conn of Deno.listen({ port })) {
    server.handle(conn);
  }
};

await main(50051);
