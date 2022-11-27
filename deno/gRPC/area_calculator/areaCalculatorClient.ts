import { getClient } from "https://deno.land/x/grpc_basic@0.4.6/client.ts";
import { Calculator } from "./area_calculator.d.ts";
import * as path from "https://deno.land/std/path/mod.ts";

console.log('area calc proto path')
console.log(path.join(Deno.cwd(),'proto','area_calculator.proto'))
let protoFile:string;

 const protoPath = new URL(path.join(Deno.cwd(),'proto','area_calculator.proto'), import.meta.url);
 console.log(Deno.build.os)
 if (Deno.build.os === "windows") {
   protoFile = await Deno.readTextFile("D:\\a\\hello_ffi\\hello_ffi\\proto\\area_calculator.proto");
 } else {
  protoFile = await Deno.readTextFile(protoPath);
 }

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
