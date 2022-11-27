import { getClient } from "https://deno.land/x/grpc_basic@0.4.6/client.ts";
const protoPath = new URL("../proto/plugin.proto", import.meta.url);
const protoFile = await Deno.readTextFile(protoPath);

const client = getClient({
    port: 50051,
    root: protoFile,
    serviceName: "PactPlugin",
  });

  console.log(client)
  
  /* unary calls */
  console.log(await client.InitPlugin({ name: "unary #1" }));
  console.log(await client.UpdateCatalogue({
    "catalogue": [
      {
        "type": 0,
        "key": "Hello",
        "values": {
          "Hello": "Hello"
        }
      }
    ]
  }))
  
  // /* server stream */
  // for await (const reply of client.ShoutHello({ name: "streamed" })) {
  //   console.log(reply);
  // }
  
  client.close();