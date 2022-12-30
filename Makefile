test_ci:
	act --container-architecture linux/amd64 --job ruby

# usage: make test JOB=lua
test: 
	act --container-architecture linux/amd64 --job $(JOB)

get_pact_ffi:
	./script/download-libs.sh

get_pact_plugins: get_plugin_cli install_protobuf_plugin

get_plugin_cli:
	./script/download-plugin-cli.sh

install_protobuf_plugin:
	${HOME}/.pact/cli/plugin/pact-plugin-cli -y install https://github.com/pactflow/pact-protobuf-plugin/releases/latest

haskell_hello_ffi:
	ghc haskell/hello_ffi.hs ${pactffi_filename} -o haskell/hello_ffi_haskell > /dev/null && ./haskell/hello_ffi_haskell

haskell: haskell_hello_ffi

ada_hello_ffi:
	cd ada && gnatmake -aI../ helloffi.adb -largs -lpact_ffi -L../osxx86 && DYLD_LIBRARY_PATH=$$PWD/../osxx86 ./helloffi

ada: ada_hello_ffi
perl_hello_ffi:
	perl perl/hello_ffi.pl

perl_hello_grpc:
	perl perl/hello_grpc.pl

perl_hello_pact_mock_server:
	perl perl/hello_pact_mock_server.pl

perl: perl_hello_ffi perl_hello_grpc perl_hello_pact_mock_server

php_hello_ffi:
	php php/hello_ffi.php

php_run_hello_grpc:
	php php/hello_grpc.php

php: php_hello_ffi

python_install_deps:
	cd python/cffi && pip install -r requirements.txt

python_hello_ffi_cffi:
	python python/cffi/hello_ffi.py

python_hello_ffi_ctypes:
	python python/ctypes/hello_ffi.py

python_hello_ffi: python_hello_ffi_cffi python_hello_ffi_ctypes
python: python_hello_ffi

ruby_hello_ffi_fiddle:
	ruby ruby/fiddle/hello_ffi.rb

ruby_hello_ffi_ffi_deps:
	cd ruby/ffi && bundle install

ruby_hello_ffi_ffi:
	ruby ruby/ffi/hello_ffi.rb

ruby_hello_ffi: ruby_hello_ffi_fiddle ruby_hello_ffi_ffi 

ruby: ruby_hello_ffi

raku_hello_ffi:
	raku raku/hello_ffi.raku

raku_hello_pact_mock_server:
	raku raku/hello_pact_mock_server.raku

raku: raku_hello_ffi raku_hello_pact_mock_server

racket_hello_ffi:
	racket racket/helloFfi.rkt

racket: racket_hello_ffi

julia_hello_ffi:
	julia julia/hello_ffi.jl

julia: julia_hello_ffi

.PHONY: bun deno features haskell java julia perl php python raku ruby zig c dart scala lua

clean_haskell:
	rm -rf haskell/hello_ffi_haskell
	rm -rf haskell/hello_ffi.hi
	rm -rf haskell/hello_ffi.o

clean: clean_haskell


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

deno_hello_ffi:
	deno run --allow-ffi --unstable deno/hello_ffi.ts

deno_run_pact_mock_server:
	deno run --allow-all --unstable deno/hello_pact_mock_server.ts

deno_run_pact_grpc:
	deno run --allow-all --unstable deno/hello_pact_grpc.ts

deno_compile_plugin_and_test:
	deno compile --allow-all --unstable deno/gRPC/pact_plugin/pactPluginServer.ts && mv pactPluginServer ~/.pact/plugins/denopactplugin-0.0.1 && deno run --allow-all --unstable deno/gRPC/pact_plugin/testPactPluginWithProtobuf.ts

deno: deno_run_download_ffi deno_hello_ffi deno_run_pact_mock_server deno_run_pact_grpc deno_compile_plugin_and_test

csharp_hello_ffi:
	cd csharp && mcs helloPact.cs && mono helloPact.exe

csharp: csharp_hello_ffi

bun_hello_ffi:
	bun bun/index.ts

bun: bun_hello_ffi

zig_get:
	curl -sS https://webi.sh/zig| sh

zig_hello:
	zig run zig/hello.zig

zig_hello_ffi:
	zig run zig/hello_ffi.zig -L./ -lpact_ffi -lc

zig_run_pact_mock_server:
	zig run zig/hello_pact_mock_server.zig -L./ -lpact_ffi --library curl --library c $(pkg-config --cflags libcurl) -lc

zig: zig_hello zig_hello_ffi zig_run_pact_mock_server

dart_gen_bindings:
	dart pub add --dev ffigen && dart pub add ffi && dart run ffigen

dart_hello_ffi: dart_setup
	dart dart/hello_ffi.dart

dart_setup: 
	cd dart && dart pub get > /dev/null

dart: dart_setup dart_hello_ffi

c_hello_ffi:
	gcc c/hello_ffi.c -L./ -lpact_ffi -o c/hello_ffi && ./c/hello_ffi

c: c_hello_ffi

swift_hello_ffi:
	swiftc swift/hello_ffi.swift -import-objc-header pact.h -L${PWD} -lpact_ffi$(DLL) -o swift/hello_ffi && ./swift/hello_ffi

swift_hello_grpc:
	swiftc swift/hello_grpc.swift -import-objc-header pact.h -L${PWD} -lpact_ffi$(DLL) -o swift/hello_grpc && ./swift/hello_grpc

lua_hello_grpc:
	cd lua && luajit hello_grpc.lua

lua_hello_ffi:
	cd lua && luajit hello_ffi.lua

lua: lua_hello_ffi lua_hello_grpc

scala_native_hello_ffi:
	cd scala-native && sbt nativeLink > /dev/null && DYLD_LIBRARY_PATH=$$PWD/.. target/scala-2.12/scala-native-out

scala_native: scala_native_hello_ffi

scala_hello_world:
	cd scala && scala$(BAT) hello.scala

scala_test_ffi:
	cd scala && scala$(BAT) ffi.scala
# scala_hello_world:
# 	scala scala/hello.scala

# scala_test_ffi:
# 	scala scala/ffi.scala

scala: scala_hello_world

# Swift requires pact_ffi.dll.lib
swift: swift_hello_ffi swift_hello_grpc

nim_hello_ffi:
	nim$(EXE) c -r --hints:off nim/hello_ffi.nim

nim_hello_world:
	nim$(EXE) c -r --hints:off nim/hello.nim

nim: nim_hello_world nim_hello_ffi
	
ifeq ($(OS),Windows_NT)
    pactffi_filename = 'pact_ffi.dll'
	DLL=.dll
	EXE=.exe
	BAT=.bat 
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        pactffi_filename = 'libpact_ffi.so'
    endif
    ifeq ($(UNAME_S),Darwin)
        pactffi_filename = 'libpact_ffi.dylib'
    endif
endif




# ada_hello_ffi \
# get_pact_ffi \

visual_basic_hello_ffi:
	cd vb && vbc helloPact.vb  > /dev/null && mono helloPact.exe

visual_basic: visual_basic_hello_ffi

go_hello_ffi:
	cd go && go build && DYLD_LIBRARY_PATH=$$PWD/.. ./hello_ffi

go: go_hello_ffi

js_ffi_napi_hello_ffi:
	cd js/node-ffi-napi && npm i  > /dev/null && DYLD_LIBRARY_PATH=$$PWD/../.. node index.js 

js_ffi_packager_hello_ffi:
	cd js/node-ffi-packager && npm run generate && DYLD_LIBRARY_PATH=$$PWD/../.. node index.js

kotlin_hello_ffi:
	cd kotlin && gradle nativeBinaries > /dev/null && DYLD_LIBRARY_PATH=$$PWD/.. build/bin/native/debugExecutable/kotlin.kexe

kotlin: kotlin_hello_ffi

ocaml_hello_ffi:
	./ocaml/helloffi.ml

ocaml: ocaml_hello_ffi

tcl_hello:
	tclsh tcl/hello.tcl

tcl: tcl_hello

java_jna_hello_ffi:
	java -cp java/jna/jna-5.12.1.jar java/jna/src/ffi/example/jna/HelloFfi.java

java_panama_ffi_gen:
	cd java/panama && jextract-19/bin/jextract \
		--output src \
		-t org.pact \
		-I /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include \
		-l$$PWD/../../libpact_ffi.dylib ../../pact.h
	cd java/panama && jextract-19/bin/jextract \
		--source \
		--output src \
		-t org.pact \
		-I /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include \
		-l$$PWD/../../libpact_ffi.dylib ../../pact.h

java_panama_hello_ffi:
	java -classpath ./java/panama/src --enable-native-access=ALL-UNNAMED --enable-preview --source 19 java/panama/Panama.java

java_jna_hello:
	java -cp java/jna/jna-5.12.1.jar java/jna/src/ffi/example/jna/Hello.java

java: java_jna_hello java_jna_hello_ffi

.PHONY: js
js: js_ffi_napi_hello_ffi js_ffi_packager_hello_ffi

hello_ffi: \
ada_hello_ffi \
bun_hello_ffi \
c_hello_ffi \
csharp_hello_ffi  \
dart_hello_ffi \
deno_hello_ffi \
haskell_hello_ffi \
go_hello_ffi \
julia_hello_ffi \
java_jna_hello_ffi \
js_ffi_napi_hello_ffi \
js_ffi_packager_hello_ffi \
kotlin_hello_ffi \
lua_hello_ffi \
nim_hello_ffi \
ocaml_hello_ffi \
perl_hello_ffi \
php_hello_ffi \
python_hello_ffi \
racket_hello_ffi \
raku_hello_ffi \
ruby_hello_ffi \
scala_native_hello_ffi \
swift_hello_ffi \
visual_basic_hello_ffi \
zig_hello_ffi

# ada 🚧 ffi version only, (also only linux)
# bun ✅ 
# c ✅ 
# csharp ✅
# dart ✅ 
# deno ✅ 
# go ✅
# haskell ✅
# julia ✅ 
# lua ✅ 
# nim ✅ 
# perl ✅ local  🚧 repl
# php  ✅
# python ✅ 
# racket ✅
# raku ✅
# ruby ✅ 
# scala 🚧 (Hello world)
# scala-native ✅
# swift ✅
# visual basic 🚧 ffi version only, (also only linux)
# zig ✅

all: haskell perl php python ruby raku julia deno bun