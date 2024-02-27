ifeq ($(DOCKER_DEFAULT_PLATFORM),)
    ifeq ($(shell uname -m),aarch64)
        DOCKER_DEFAULT_PLATFORM = linux/arm64
    else
        DOCKER_DEFAULT_PLATFORM = linux/amd64
    endif
endif

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
	${HOME}/.pact/cli/plugin/pact-plugin-cli -y install https://github.com/you54f/pact-protobuf-plugin/releases/latest

clean: clean_haskell

alpine_haskell:
	docker run -v ${PWD}:/app --rm alpine sh -c 'apk add ghc make musl-dev && cd /app && make haskell_hello_ffi'

haskell_hello_ffi:
	ghc haskell/hello_ffi.hs ${pactffi_filename} -o haskell/hello_ffi_haskell
	$(LOAD_PATH) ./haskell/hello_ffi_haskell

haskell: haskell_hello_ffi

clean_haskell:
	rm -rf haskell/hello_ffi_haskell
	rm -rf haskell/hello_ffi.hi
	rm -rf haskell/hello_ffi.o


alpine_ada:
	docker run -v ${PWD}:/app --rm alpine sh -c 'apk add gcc-gnat make && cd /app && make ada_hello_ffi'

ada_hello_ffi:
	cd ada && gnatmake helloffi.adb -largs -lpact_ffi -L../.
	$(LOAD_PATH) ./ada/helloffi

# if [ "$(shell uname -s)_$(shell uname -m)" = "Darwin_arm64" ]; \
# then \
# 	cd ada && gnatmake -aI../ helloffi.adb -largs -lpact_ffi -L../osxx86 && $(LOAD_PATH)/../osxx86 ./helloffi; \
# else \
# 	cd ada && gnatmake -aI../ helloffi.adb -largs -lpact_ffi -L.. && $(LOAD_PATH)/.. ./helloffi; \
# fi; \

ada: ada_hello_ffi

alpine_perl:
	docker run -v ${PWD}:/app --rm alpine sh -c 'apk add perl make libgcc protoc && apk add perl-ffi-platypus perl-json --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && cd /app && make perl'

perl_install_deps:
	cpan FFI::Platypus<<<yes

perl_hello_ffi:
	$(LOAD_PATH) perl perl/hello_ffi.pl

perl_hello_grpc:
	$(LOAD_PATH) perl perl/hello_grpc.pl

perl_hello_pact_mock_server:
	$(LOAD_PATH) perl perl/hello_pact_mock_server.pl

perl: perl_hello_ffi perl_hello_grpc perl_hello_pact_mock_server

alpine_php:
	docker run -v ${PWD}:/app --rm alpine sh -c 'apk add php make php82-ffi libgcc protoc && cd /app && make php'

php_hello_ffi:
	php php/hello_ffi.php

php_run_hello_grpc:
	php php/hello_grpc.php

php: php_hello_ffi php_run_hello_grpc

alpine_python:
	docker run -v ${PWD}:/app --rm alpine sh -c 'apk add make python3 python3-dev py-pip gcc musl-dev libffi-dev && cd /app && python3 -m venv /home/venv && . /home/venv/bin/activate && make python_install_deps && make python'

python_install_deps:
	cd python/cffi && pip install -r requirements.txt

python_hello_ffi_cffi:
	python3 python/cffi/hello_ffi.py

python_hello_ffi_ctypes:
	python3 python/ctypes/hello_ffi.py

python_hello_ffi: python_hello_ffi_cffi python_hello_ffi_ctypes
python: python_hello_ffi

alpine_ruby:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make ruby ruby-dev ruby-bundler build-base libffi-dev && cd /app && make ruby_install_deps && make ruby'

ruby_hello_ffi_fiddle:
	ruby ruby/fiddle/hello_ffi.rb

ruby_hello_ffi_ffi_deps:
	cd ruby/ffi && bundle install

ruby_install_deps: ruby_hello_ffi_ffi_deps

ruby_hello_ffi_ffi:
	ruby ruby/ffi/hello_ffi.rb

ruby_hello_ffi: ruby_hello_ffi_fiddle ruby_hello_ffi_ffi 

ruby: ruby_hello_ffi

alpine_raku:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make rakudo gcc && cd /app && make raku'

raku_hello_ffi:
	$(LOAD_PATH) rakudo raku/hello_ffi.raku

raku_hello_pact_mock_server:
	$(LOAD_PATH) rakudo raku/hello_pact_mock_server.raku

raku: raku_hello_ffi raku_hello_pact_mock_server

alpine_racket:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make racket gcc && cd /app && make racket'

racket_hello_ffi:
	racket racket/helloFfi.rkt

racket: racket_hello_ffi

alpine_julia: # needs an x86_64 binary
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} --platform=linux/amd64 -v ${PWD}:/app --rm julia:alpine sh -c 'apk add make gcc musl-dev && cd /app && make julia'

julia_hello_ffi:
	$(LOAD_PATH) julia julia/hello_ffi.jl

julia: julia_hello_ffi

.PHONY: bun deno features haskell java julia perl php python raku ruby zig c dart scala lua

alpine_deno:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make deno protoc && cd /app && make deno'


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
	$(LOAD_PATH) deno run --allow-ffi --unstable deno/hello_ffi.ts

deno_run_pact_mock_server:
	$(LOAD_PATH) deno run --allow-all --unstable deno/hello_pact_mock_server.ts

deno_run_pact_grpc:
	$(LOAD_PATH) deno run --allow-all --unstable deno/hello_pact_grpc.ts

deno_compile_plugin_and_test:
	deno compile --allow-all --unstable deno/gRPC/pact_plugin/pactPluginServer.ts && mv pactPluginServer ~/.pact/plugins/denopactplugin-0.0.1 && $(LOAD_PATH) deno run --allow-all --unstable deno/gRPC/pact_plugin/testPactPluginWithProtobuf.ts

deno: deno_hello_ffi deno_run_pact_mock_server deno_run_pact_grpc deno_compile_plugin_and_test

alpine_csharp:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make && apk add mono --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && cd /app && make csharp'

csharp_hello_ffi:
	cd csharp && $(MCS_COMPILER) helloPact.cs
	$(LOAD_PATH) $(MONO) csharp/helloPact.exe

csharp: csharp_hello_ffi

# if [ "$(shell uname -s)_$(shell uname -m)" = "Darwin_arm64" ]; \
# then \
# 	cd csharp && $(MCS_COMPILER) helloPact.cs && $(LOAD_PATH)/../osxx86 mono helloPact.exe; \
# else \
# 	cd csharp && $(MCS_COMPILER) helloPact.cs && $(LOAD_PATH)/.. mono helloPact.exe; \
# fi; \
	
alpine_bun:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm oven/bun:alpine sh -c 'apk add make && cd /app && make bun'

# alpine_bun:
# 	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make bash curl patchelf gcc libffi libffi-dev musl-dev && curl -LO https://raw.githubusercontent.com/YOU54F/bun-musl/main/bun-musl && chmod +x bun-musl && ./bun-musl install && export PATH=$$PATH:$$HOME/.bun/bin && cd /app && make bun'

bun_hello_ffi:
	bun bun/index.ts

bun: bun_hello_ffi

alpine_zig:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm oven/bun:alpine sh -c 'apk add make curl curl-dev && apk add zig --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && cd /app && make zig'

zig_get:
	curl -sS https://webi.sh/zig| sh

zig_hello:
	zig run zig/hello.zig

zig_hello_ffi:
	zig run zig/hello_ffi.zig -L./ -l$(pactffi_libname) -lc

zig_run_pact_mock_server:
	zig run zig/hello_pact_mock_server.zig -L./ -l$(pactffi_libname) --library curl --library c $(pkg-config --cflags libcurl) -lc

zig: zig_hello zig_hello_ffi zig_run_pact_mock_server

alpine_dart:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make ca-certificates && apk add dart --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && cd /app && make dart_hello_ffi'

dart_gen_bindings:
	dart pub add --dev ffigen && dart pub add ffi && dart run ffigen

dart_hello_ffi: dart_setup
	dart dart/hello_ffi.dart

dart_setup: 
	cd dart && dart pub get

dart: dart_setup dart_hello_ffi

alpine_c:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make gcc musl-dev && cd /app && make c'

c_hello_ffi:
	gcc c/hello_ffi.c -L./ -lpact_ffi -o c/hello_ffi
	$(LOAD_PATH) ./c/hello_ffi

c: c_hello_ffi

# SwiftLang Outstanding issues
# https://github.com/apple/swift/issues/47209
# alpine_swift:
# 	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make swift && cd /app && make swift'

swift_hello_ffi:
	swiftc swift/hello_ffi.swift -import-objc-header pact.h -L${PWD} -lpact_ffi$(DLL) -o swift/hello_ffi
	$(LOAD_PATH) ./swift/hello_ffi

swift_hello_grpc:
	swiftc swift/hello_grpc.swift -import-objc-header pact.h -L${PWD} -lpact_ffi$(DLL) -o swift/hello_grpc && $(LOAD_PATH) ./swift/hello_grpc

swift: swift_hello_ffi swift_hello_grpc

alpine_lua:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make lua luajit protoc && cd /app && make lua'

lua_hello_grpc:
	cd lua && luajit hello_grpc.lua

lua_hello_ffi:
	cd lua && luajit hello_ffi.lua

lua: lua_hello_ffi lua_hello_grpc

# TODO
# alpine_scala_native:
# 	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make && cd /app && make scala_native'

scala_native_deps:
	mkdir -p scala-native/src/main/resources/scala-native/
	cp pact.h scala-native/src/main/resources/scala-native/pact.h

scala_native_hello_ffi:
	cd scala-native && sbt nativeLink && $(LOAD_PATH)/.. target/scala-2.12/scala-native-out

scala_native: scala_native_hello_ffi

# TODO
# alpine_scala:
# 	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make && cd /app && make scala'

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

alpine_nim:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make nim gcc musl-dev && cd /app && make nim'

nim_hello_ffi:
	$(LOAD_PATH) nim$(EXE) c -r --hints:off nim/hello_ffi.nim

nim_hello_world:
	$(LOAD_PATH) nim$(EXE) c -r --hints:off nim/hello.nim

nim: nim_hello_world nim_hello_ffi

GO_CMD=go	


ABS_PATH_FFI_LIB=$(PWD)/$(pactffi_filename)
JEXTRACT_PATH=./jextract-19/bin/jextract
ifeq ($(OS),Windows_NT)
	# This will allow powershell to use PWD
	# it will reverse slashes to backslashes
	# only seems to be relevant to java panama linking
	ifndef ${PWD}
	override PWD := $(subst /,\,$(CURDIR))
	ABS_PATH_FFI_LIB=$(subst /,\,$(PWD)/$(pactffi_filename))
	JEXTRACT_PATH=$(subst /,\,$(JEXTRACT_PATH))
	endif
	
    pactffi_filename = pact_ffi.dll
	pactffi_libname = pact_ffi.dll
	DLL=.dll
	EXE=.exe
	BAT=.bat
	# LOAD_PATH=$$env:LD_LIBRARY_PATH=$$env:PWD.Path;
	STD_LIB_DIR=TODO
	VBC_COMPILER="C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\Roslyn\vbc.exe"
	MCS_COMPILER="C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\Roslyn\csc.exe"
	# VBC_COMPILER=vbc.exe
	GO_CMD=go1.20rc1
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        pactffi_filename = libpact_ffi.so
        pactffi_libname = pact_ffi
		LOAD_PATH=LD_LIBRARY_PATH=$$PWD
		STD_LIB_DIR=/usr/include
		VBC_COMPILER?=vbnc
		MCS_COMPILER=mcs
		MONO=mono
    endif
    ifeq ($(UNAME_S),Darwin)
        pactffi_filename = libpact_ffi.dylib
        pactffi_libname = pact_ffi
		LOAD_PATH=DYLD_LIBRARY_PATH=$$PWD
		STD_LIB_DIR=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include
		VBC_COMPILER=vbc
		MCS_COMPILER=mcs
		MONO=mono
    endif
endif

# TODO: https://pkgs.alpinelinux.org/contents?file=Microsoft.VisualBasic.dll&path=&name=mono&branch=edge&repo=testing&arch=x86_64
# vbc : error BC2017: could not find library 'Microsoft.VisualBasic.dll'
alpine_visual_basic:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make && apk add mono --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/  && cd /app && VBC_COMPILER=vbc make visual_basic'

visual_basic_hello_ffi:
	cd vb && $(VBC_COMPILER) helloPact.vb
	$(LOAD_PATH) $(MONO) vb/helloPact.exe

visual_basic: visual_basic_hello_ffi

alpine_go:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make go gcc musl-dev && cd /app && CGO_ENABLED=1 make go'
go_hello_ffi:
	cd go && $(GO_CMD) build
	$(LOAD_PATH) go/hello_ffi

go: go_hello_ffi

alpine_js:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make nodejs npm python3 python3-dev gcc g++ && cd /app && make js_ffi_napi_hello_ffi'
js_ffi_napi_hello_ffi:
	cd js/node-ffi-napi && npm i
	$(LOAD_PATH) node js/node-ffi-napi/index.js 

js_ffi_packager_gen_bindings:
	cd js/node-ffi-packager && npm run generate

js_ffi_packager_hello_ffi:
	cd js/node-ffi-packager && npm i
	$(LOAD_PATH) node js/node-ffi-packager/index.js

.PHONY: js
js: js_ffi_napi_hello_ffi js_ffi_packager_hello_ffi

# TODO
# Could not find :kotlin-native-prebuilt-linux-aarch64:1.7.21.
# alpine_kotlin:
# 	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make openjdk11 && apk add gradle --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && cd /app && make kotlin'
kotlin_hello_ffi:
	cd kotlin && gradle nativeBinaries > /dev/null && $(LOAD_PATH)/.. build/bin/native/debugExecutable/kotlin.kexe

kotlin: kotlin_hello_ffi

# TODO
# env: can't execute 'utop': No such file or directory
alpine_ocaml:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make ocaml gcc musl-dev && apk add ocaml-utop ocaml-utop-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && cd /app && make ocaml'
ocaml_hello_ffi:
	$(LOAD_PATH) ./ocaml/helloffi.ml

ocaml: ocaml_hello_ffi

# alpine_tcl:
# 	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make tcl tcl-dev gcc musl-dev && cd /app && make tcl'
# tcl_hello:
# 	tclsh tcl/hello.tcl

# tcl: tcl_hello
alpine_java:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make openjdk19 libgcc && cd /app && make java'
java_jna_hello_ffi:
	$(LOAD_PATH) java -cp java/jna/jna-5.12.1.jar java/jna/src/ffi/example/jna/HelloFfi.java
java_jna_hello:
	$(LOAD_PATH) java -cp java/jna/jna-5.12.1.jar java/jna/src/ffi/example/jna/Hello.java

java: java_jna_hello java_jna_hello_ffi

# TODO
# No jextract musl or aarch64 builds
alpine_java_panama:
	docker run --platform=linux/${DOCKER_DEFAULT_PLATFORM} -v ${PWD}:/app --rm alpine sh -c 'apk add make openjdk19 libgcc && cd /app && make java_panama'
java_panama_ffi_gen:
	cd java/panama && $(JEXTRACT_PATH) --output src -t org.pact -l$(ABS_PATH_FFI_LIB) ../../pact.h
	cd java/panama && $(JEXTRACT_PATH) --source --output src -t org.pact -l$(ABS_PATH_FFI_LIB) ../../pact.h

java_panama_hello_ffi: java_panama_ffi_gen
	java -classpath ./java/panama/src --enable-native-access=ALL-UNNAMED --enable-preview --source 19 java/panama/Panama.java

java_panama: java_panama_ffi_gen java_panama_hello_ffi

hello_ffi: \
ada_hello_ffi \
bun_hello_ffi \
c_hello_ffi \
csharp_hello_ffi  \
dart_hello_ffi \
deno_hello_ffi \
go_hello_ffi \
haskell_hello_ffi \
java_jna_hello_ffi \
java_panama_hello_ffi \
js_ffi_napi_hello_ffi \
js_ffi_packager_hello_ffi \
julia_hello_ffi \
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