import { GrpcServer } from "https://deno.land/x/grpc_basic@0.4.6/server.ts";
import { Calculator, ShapeMessage } from "./area_calculator.d.ts";

const server = new GrpcServer();

const protoPath = new URL(
  `${Deno.cwd()}/proto/area_calculator.proto`,
  import.meta.url
);
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
          value: [message.square.edgeLength * message.square.edgeLength]
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
        const p =
          (message.triangle.edgeA +
            message.triangle.edgeB +
            message.triangle?.edgeC) /
          2.0;
        const area = Math.sqrt(
          p *
            (p - message.triangle.edgeA) *
            (p - message.triangle.edgeB) *
            (p - message.triangle.edgeC)
        );
        return { value: [area] };
      default:
        throw new Error(`Error: not a valid shape ${message}`);
    }
  },
  async calculateMulti(message) {
    console.log(`Unimplemented  ${JSON.stringify(message)}`);
    return { value: [1] };
  }
});

const main = async (port = 37757) => {
  console.log(`gRPC Area Calculator running on port: ${port}`);
  for await (const conn of Deno.listen({ port })) {
    server.handle(conn);
  }
};

await main(37757);
