import { getClient } from "https://deno.land/x/grpc_basic@0.4.6/client.ts";
import { Calculator } from "./area_calculator.d.ts";
import * as path from "https://deno.land/std/path/mod.ts";

const protoPath = new URL(path.join(Deno.cwd(),'proto','area_calculator.proto'), import.meta.url);
const protoFile = await Deno.readTextFile(Deno.build.os === "windows" ? protoPath.href : protoPath);

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
