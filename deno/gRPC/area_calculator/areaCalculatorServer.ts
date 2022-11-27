import { GrpcServer } from "https://deno.land/x/grpc_basic@0.4.6/server.ts";
import { Calculator } from "./area_calculator.d.ts";

const server = new GrpcServer();

const protoPath = new URL("../proto/area_calculator.proto", import.meta.url);
const protoFile = await Deno.readTextFile(protoPath);

server.addService<Calculator>(protoFile, {
  async calculateOne(message) {
    console.log(
      `Calculating the area for one value  ${JSON.stringify(message)}`
    );
    switch (message.shape) {
      case "rectangle":
        console.log();
        return { value: [message.rectangle.length * message.rectangle.width] };
      case "square":
        return {
          value: [message.square.edge_length * message.square.edge_length]
        };
      case "circle":
        return {
          value: [Math.PI * message.circle.radius * message.circle.radius]
        };
      case "parallelogram":
        return {
          value: [
            message.parallelogram.base_length * message.parallelogram.height
          ]
        };
      case "triangle":
          const p = ((message.triangle.edge_a + message.triangle.edge_b + message.triangle.edge_c) / 2.0)
          const area = Math.sqrt((p * (p - message.triangle.edge_a) * (p - message.triangle.edge_b) * (p - message.triangle.edge_c)))
          return {value:[area]}
        break;
      default:
        throw new Error(`Error: not a valid shape ${message}`);
    }
  }
});

const main = async (port = 50051) => {
  console.log(`gRPC Area Calculator running on port: ${port}`);
  for await (const conn of Deno.listen({ port })) {
    server.handle(conn);
  }
};

await main(50051)