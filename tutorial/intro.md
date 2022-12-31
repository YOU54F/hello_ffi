## Tutorial Prerequisites

- Nothing! Just you and a bit of time

1. `git clone https://github.com/YOU54F/hello_ffi.git`{{exec}}
2. `cd hello_ffi`{{exec}}
3. `make get_pact_ffi`{{exec}}

## Ada

https://www.adacore.com/download

1. `apt-cache search gnat-10`{{exec}}
1. `apt-get --yes install gnat-10`{{exec}}
1. `gnat --version`{{exec}}
2. `make ada_hello_ffi`{{exec}}

## Bun

https://bun.sh/

1. `curl -fsSL https://bun.sh/install | bash`{{exec}}
2. `source /root/.bashrc`{{exec}}
3. `bun --version`{{exec}}
4. `make bun_hello_ffi`{{exec}}

## C

1.  `gcc --version`{{exec}}
2.  `make c_hello_ffi`{{exec}}

## C #

https://www.mono-project.com/docs/about-mono/languages/csharp/
https://www.mono-project.com/docs/getting-started/install/

1. `apt-get install --yes mono-mcs`{{exec}}
2. `make csharp_hello_ffi`{{exec}}


## Dart

https://dart.dev/get-dart

1. `wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg`{{exec}}
2. `echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list`{{exec}}
3. `apt-get update`{{exec}}
4. `apt-get install dart`{{exec}}
2. `dart --version`{{exec}}
3. `make dart_hello_ffi`{{exec}}

## Deno

https://deno.land/manual@v1.29.1/getting_started/installation

1. `curl -fsSL https://deno.land/x/install/install.sh | sh`{{exec}}
2. `export DENO_INSTALL="/root/.deno"`{{exec}}
3. `export PATH="$DENO_INSTALL/bin:$PATH"`{{exec}}
2. `source /root/.bashrc`{{exec}}
2. `deno --version`{{exec}}
3. `make deno_hello_ffi`{{exec}}


## GoLang

https://go.dev/doc/install

1. `go version`{{exec}}
2. `make go_hello_ffi`{{exec}}

## Haskell

https://www.haskell.org/downloads/

1. `apt-get install --yes ghc`{{exec}}
2. `ghc --version`{{exec}}
3. `make haskell_hello_ffi`{{exec}}

## Java

1. `wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz`{{exec}}
2. `mkdir /usr/lib/jvm`{{exec}}
3. `cd /usr/lib/jvm`{{exec}}
4. `tar -xvzf ~/hello_ffi/jdk-19_linux-x64_bin.tar.gz`{{exec}}
5. `export JAVA_HOME="/usr/lib/jvm/jdk-19.0.1"`{{exec}}
6. `export PATH="/usr/lib/jvm/jdk-19.0.1/bin:$PATH"`{{exec}}
7. `cd ~/hello_ffi`{{exec}}


### Java Native Access

1. `make java_jna_hello_ffi`{{exec}}

### Java Panama

https://openjdk.org/projects/panama/
https://jdk.java.net/jextract/

1. `wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.java.net/java/early_access/jextract/2/openjdk-19-jextract+2-3_linux-x64_bin.tar.gz`{{exec}}
2. `tar -xzf openjdk-19-jextract+2-3_linux-x64_bin.tar.gz -C java/panama`{{exec}}
3. `make java_panama_ffi_gen`{{exec}}
4. `make java_panama_hello_ffi`{{exec}}
   

## JavaScript

1. `wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash`{{exec}}
1. `source ~/.bashrc`{{exec}}
2. `nvm install 16`{{exec}}


### node-addon-api

### node-ffi-napi

3. `make js_ffi_napi_hello_ffi`{{exec}}

### node-ffi-packager

https://github.com/node-ffi-packager/node-ffi-generate

<!-- 1. `apt-get install clang`
1. `apt install llvm`
2. `ln -s /usr/lib/llvm-10/lib/libclang.so.1 /usr/lib/llvm-10/lib/libclang.so`
3. `apt-get install -y libclang-dev`
4. `LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu` -->
5. `make js_ffi_packager_hello_ffi`{{exec}}


## Julia

https://julialang.org/downloads/

1. `apt-get install --yes julia`{{exec}}
2. `make julia_hello_ffi`{{exec}}


<!-- ## Kotlin

https://kotlinlang.org/docs/native-c-interop.htm

1. `apt-get install --yes gradle`
2. `make kotlin_hello_ffi` -->

## Lua

https://luajit.org/install.html

1. `apt-get install --yes luajit`{{exec}}
2. `luajit --version`{{exec}}
3. `make lua_hello_ffi`{{exec}}

## Nim

https://nim-lang.org/install.html

1. `apt-get install --yes nim`{{exec}}
2. `nim --version`{{exec}}
3. `make nim_hello_ffi`{{exec}}

## OCaml

## Perl

## PHP

## Python

## Racket

## Raku

## Ruby

## Scala-Native

## Swift

## Visual Basic

## Zig

<!-- ## Install Deno

2. `curl -fsSL https://deno.land/x/install/install.sh | sh`{{exec}}
3. `echo 'export DENO_INSTALL="/root/.deno"' >> ~/.bashrc`{{exec}}
4. `echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc`{{exec}}
5. `source ~/.bashrc`{{exec}}

## Get the Pact FFI

5. `deno run -A --unstable https://deno.land/x/pact/src/downloadFfi.ts --run`{{exec}}
6. `touch helloPactDeno.ts`{{exec}}

```ts
import { DenoPact, Pact } from "https://deno.land/x/pact/src/mod.ts";
const denoPact = new DenoPact();
console.log(denoPact.getPactFfiVersion());
```{{copy}}

7. `deno run -A --unstable helloPactDeno.ts`{{exec}}

## Run the Examples


2. `git clone https://github.com/YOU54F/deno-pact`{{exec}}
3. `cd deno-pact`{{exec}}
4. `./run get_pact_ffi`{{exec}}
7. `./run get_pact_plugin_cli`{{exec}}
8. `PATH_TO_CLI=/root/bin/ ./run get_protobuf_plugin`{{exec}}

## gRPC AreaCalculator

8. `./run test_grpc_area_client`{{exec}}
9. `./run test_grpc_area_provider`{{exec}}
10. `./run start_area_calculator_provider`{{exec}}
11. `./run run_area_calculator`{{exec}}

## gRPC Greeter

12. `./run run_grpc_greeter`{{exec}}
13. `./run test_grpc_greeter_client`{{exec}}

## HTTP Service

14. `./run run_product_api_provider`{{exec}}
15. `./run test_product_api_provider`{{exec}}

## HTTP Service

16. `./run run_smv_service`{{exec}}
17. `./run test_smv_service_provider_integration`{{exec}}
18. `./run test_smv_service_consumer_pact`{{exec}}
19. `./run test_smv_service_provider_pact`{{exec}}

##  Pact Verifier

20. `./run test_verifier_pact`{{exec}}

## Pact Broker

25. `curl pact.saf.dev -Lso - | bash -s -- broker deploy mybroker 8000`{{exec}}
    1. Open the [Pact Broker]({{TRAFFIC_HOST1_8000}}) and observe it's contents.
    2. You can check the Docker logs for the Pact Broker, `docker logs mybroker_pact_broker_1`{{exec}}
    3. Restart the container if there was any issues `docker restart mybroker_pact_broker_1`{{exec}}

5. `./run get_broker`{{exec}}
6. Open the [Pact Broker]({{TRAFFIC_HOST1_9292}}) -->
