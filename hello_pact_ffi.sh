#!/bin/sh

# shellcheck disable=SC2028

_="
---
args:
  - sh
---
"


pactffi_filename=${HOME}/.pact/ffi/v0.3.15/libpact_ffi.dylib
echo '\n*** Interpreters ***\n'
echo ${pactffi_filename}
echo 'hello from Deno'
tea -X deno run -A --unstable deno/downloadFfi.ts
tea -X deno run -A --unstable deno/hello_ffi.ts


echo 'hello from C'
tea -X gcc c/hello_ffi.c -L./ -lpact_ffi -o c/hello_ffi && ./c/hello_ffi


# echo haskell
# tea -X ghc haskell/hello_ffi.hs ${pactffi_filename} -o haskell/hello_ffi_haskell && ./haskell/hello_ffi_haskell




# echo haskell
# tea -X ghc haskell/hello_ffi.hs ${pactffi_filename} -o haskell/hello_ffi_haskell && ./haskell/hello_ffi_haskell

echo perl_hello_ffi:
# tea cpan App::cpanminus
# tea cpanm Capture::Tiny 
# tea cpanm FFI::Platypus
tea -X perl perl/hello_ffi.pl

# echo perl_hello_grpc:
# tea -X perl perl/hello_grpc.pl

# echo perl_hello_pact_mock_server:
# tea -X perl perl/hello_pact_mock_server.pl

# echo php_run_hello_world:
# tea -X cd php && composer hello_ffi

# echo python_install_deps:
# tea -X cd python/cffi && pip install -r requirements.txt

# echo python_cffi: python_install_deps
# tea -X python python/cffi/hello_ffi.py

# echo python_ctypes:
# tea -X python python/ctypes/hello_ffi.py


# echo ruby_fiddle:
# tea -X ruby ruby/fiddle/hello_ffi.rb

# echo ruby_ffi_install:
# tea -X cd ruby/ffi && bundle install

# echo ruby_ffi: ruby_ffi_install
# tea -X ruby ruby/ffi/hello_ffi.rb

# echo raku_hello_ffi:
# tea -X raku raku/hello_ffi.raku

# echo raku_hello_pact_mock_server:
# tea -X raku raku/hello_pact_mock_server.raku

# echo deno_gen_proto:
# tea -X deno run --allow-read https://deno.land/x/grpc_basic@0.4.6/gen/dts.ts ./proto/area_calculator.proto > ./deno/gRPC/area_calculator/area_calculator.d.ts

# echo deno_gen_plugin_proto:
# tea -X deno run --allow-read https://deno.land/x/grpc_basic@0.4.6/gen/dts.ts ./proto/plugin.proto > ./deno/gRPC/pact_plugin/plugin.d.ts

# echo deno_run_greeter_client:
# tea -X deno run --allow-all --unstable deno/gRPC/greeter/greeterClient.ts

# echo deno_run_greeter_server:
# tea -X deno run --allow-all --unstable deno/gRPC/greeter/greeterServer.ts

# echo deno_run_area_calculator_client:
# tea -X deno run --allow-all --unstable deno/gRPC/area_calculator/areaCalculatorClientRun.ts

# echo deno_run_area_calculator_server:
# tea -X deno run --allow-all --unstable deno/gRPC/area_calculator/areaCalculatorServer.ts

# echo deno_run_download_ffi:
# tea -X deno run --allow-all --unstable deno/downloadFfi.ts

# echo deno_run_hello_ffi:
# tea -X deno run --allow-ffi --unstable deno/hello_ffi.ts

# echo deno_run_pact_mock_server:
# tea -X deno run --allow-all --unstable deno/hello_pact_mock_server.ts

# echo deno_run_pact_grpc:
# tea -X deno run --allow-all --unstable deno/hello_pact_grpc.ts

# echo deno_compile_plugin_and_test:
# tea -X deno compile --allow-all --unstable deno/gRPC/pact_plugin/pactPluginServer.ts && mv pactPluginServer ~/.pact/plugins/denopactplugin-0.0.1 && deno run --allow-all --unstable deno/gRPC/pact_plugin/testPactPluginWithProtobuf.ts

# echo bun_hello_ffi:
# tea -X cd bun && bun index.ts

# echo zig_hello:
# tea -X zig run zig/hello.zig

# echo zig_hello_ffi:
# tea -X zig run zig/hello_ffi.zig -L./ -lpact_ffi 

# echo zig_run_pact_mock_server:
# tea -X zig run zig/hello_pact_mock_server.zig -L./ -lpact_ffi --library curl --library c $(pkg-config --cflags libcurl) 

# echo dart_hello_ffi:
# tea -X dart dart/hello_ffi.dart

# echo c_hello_ffi:
# tea -X gcc c/hello_ffi.c -L./ -lpact_ffi -o c/hello_ffi && ./c/hello_ffi

# echo swift_hello_ffi:
# tea -X swiftc swift/hello_ffi.swift -import-objc-header pact.h -L${PWD} -lpact_ffi$(DLL) -o swift/hello_ffi && ./swift/hello_ffi

# echo swift_hello_grpc:
# tea -X swiftc swift/hello_grpc.swift -import-objc-header pact.h -L${PWD} -lpact_ffi$(DLL) -o swift/hello_grpc && ./swift/hello_grpc

# echo lua_hello_grpc:
# tea -X cd lua && luajit hello_grpc.lua

# echo lua_hello_ffi:
# tea -X cd lua && luajit hello_ffi.lua

# echo scala_hello_world:
# tea -X cd scala && scala$(BAT) hello.scala

# echo scala_test_ffi:
# tea -X cd scala && scala$(BAT) ffi.scala

# echo nim_hello_ffi:
# tea -X nim$(EXE) c -r nim/hello_ffi.nim

# echo nim_hello_world:
# tea -X nim$(EXE) c -r nim/hello.nim