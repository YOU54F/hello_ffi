import { getClient } from "https://deno.land/x/grpc_basic@0.4.6/client.ts";
import { Calculator } from "./area_calculator.d.ts";

const protoPath = new URL("../../../proto/area_calculator.proto", import.meta.url);
const protoFile = await Deno.readTextFile(protoPath);


export async function getShapeMessage(port:number) {
  const client = getClient<Calculator>({
    port,
    root: protoFile,
    serviceName: "Calculator",
  });

  const result = await client.calculateOne({
    rectangle: {
      "length": 3,
      "width": 4
    }
  });
  client.close();
  return result;
}
