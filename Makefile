test_ci:
	act --container-architecture linux/amd64 --job ruby

get_pact_ffi:
	./script/download-libs.sh

get_pact_plugins: get_plugin_cli install_protobuf_plugin

get_plugin_cli:
	./script/download-plugin-cli.sh

install_protobuf_plugin:
	${HOME}/.pact/cli/plugin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest

haskell:
	ghc haskell/hello_ffi.hs ${pactffi_filename} -o haskell/hello_ffi_haskell && ./haskell/hello_ffi_haskell

perl_hello_ffi:
	perl perl/hello_ffi.pl

perl_hello_grpc:
	perl perl/hello_grpc.pl

perl_hello_pact_mock_server:
	perl perl/hello_pact_mock_server.pl

perl: perl_hello_ffi perl_hello_grpc perl_hello_pact_mock_server

php_install_deps:
	cd php && composer update && composer install
php_run_hello_work:
	cd php && composer hello_ffi
php: php_install_deps php_run_hello_work

python_install_deps:
	cd python/cffi && pip install -r requirements.txt

python_cffi: python_install_deps
	python python/cffi/hello_ffi.py

python_ctypes:
	python python/ctypes/hello_ffi.py

python: python_cffi python_ctypes

ruby_fiddle:
	ruby ruby/fiddle/hello_ffi.rb

ruby_ffi_install:
	cd ruby/ffi && bundle install

ruby_ffi: ruby_ffi_install
	ruby ruby/ffi/hello_ffi.rb

ruby: ruby_fiddle ruby_ffi

raku_hello_ffi:
	raku raku/hello_ffi.raku

raku_hello_pact_mock_server:
	raku raku/hello_pact_mock_server.raku

raku: raku_hello_ffi raku_hello_pact_mock_server

julia_hello_ffi:
	julia julia/hello_ffi.jl

julia: julia_hello_ffi

.PHONY: haskell php ruby deno

clean_haskell:
	rm -rf haskell/hello_ffi_haskell
	rm -rf haskell/hello_ffi.hi
	rm -rf haskell/hello_ffi.o

clean: clean_haskell

all: haskell perl php python ruby raku julia deno bun

deno_gen_proto:
	deno run --allow-read https://deno.land/x/grpc_basic@0.4.6/gen/dts.ts ./proto/area_calculator.proto > ./deno/gRPC/area_calculator/area_calculator.d.ts

deno_gen_plugin_proto:
	deno run --allow-read https://deno.land/x/grpc_basic@0.4.6/gen/dts.ts ./proto/plugin.proto > ./deno/gRPC/pact_plugin/plugin.d.ts

deno_run_greeter_client:
	deno run --allow-all --unstable deno/gRPC/greeter/greeterClient.ts

deno_run_greeter_server:
	deno run --allow-all --unstable deno/gRPC/greeter/greeterServer.ts

deno_run_area_calculator_client:
	deno run --allow-all --unstable deno/gRPC/area_calculator/areaCalculatorClientRun.ts

deno_run_area_calculator_server:
	deno run --allow-all --unstable deno/gRPC/area_calculator/areaCalculatorServer.ts

deno_run_download_ffi:
	deno run --allow-all --unstable deno/downloadFfi.ts

deno_run_hello_ffi:
	deno run --allow-ffi --unstable deno/hello_ffi.ts

deno_run_pact_mock_server:
	deno run --allow-all --unstable deno/hello_pact_mock_server.ts

deno_run_pact_grpc:
	deno run --allow-all --unstable deno/hello_pact_grpc.ts

deno_compile_plugin_and_test:
	deno compile --allow-all --unstable deno/gRPC/pact_plugin/pactPluginServer.ts && mv pactPluginServer ~/.pact/plugins/denopactplugin-0.0.1 && deno run --allow-all --unstable deno/gRPC/pact_plugin/testPactPluginWithProtobuf.ts

deno: deno_run_download_ffi deno_run_hello_ffi deno_run_pact_mock_server deno_run_pact_grpc deno_compile_plugin_and_test

bun_hello_ffi:
	cd bun && bun index.ts

bun: bun_hello_ffi


	
ifeq ($(OS),Windows_NT)
    pactffi_filename = 'pact_ffi.dll'
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        pactffi_filename = 'libpact_ffi.so'
    endif
    ifeq ($(UNAME_S),Darwin)
        pactffi_filename = 'libpact_ffi.dylib'
    endif
endif
