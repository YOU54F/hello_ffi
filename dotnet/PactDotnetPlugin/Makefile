PROJECT=dotnet-template
APP_NAME=GrpcPactPlugin
PLUGIN_VERSION?=$(shell ./script/bump.sh -p "v-" -l)

clean:
	rm -rf bin
	rm -rf obj
	rm -rf build

update_manifest:
	@echo ${PLUGIN_VERSION} && variable=${PLUGIN_VERSION}; jq --arg variable "$$variable" '.version = $$variable' pact-plugin.json > pact-plugin.json

proto: build

build:
	dotnet build
	
run_local:
	dotnet run

run_build:
	./GrpcPactPlugin

test_build:
	./GrpcPactPlugin & _pid=$$!; \
    sleep 3 && ./evans.sh; kill $$_pid

.PHONY: bin build


compile: clean
	dotnet publish -c Release -p:'StaticExecutable=true;StripSymbols=false;PublishSingleFile=true;StaticLink=true' --self-contained -r $(PLATFORM)-$(ARCH) -o build/${PLATFORM}/${ARCH}
	cp build/${PLATFORM}/${ARCH}/${APP_NAME} .
	if [ "${PLATFORM}" = "osx" ]; then \
		if [[ "$$(csrutil status)" == *"disabled"* ]]; then \
			echo "sip disabled"; \
			codesign -f --remove-signature ${APP_NAME}; \
		fi; \
	fi

compress:
	gzip -c build/${PLATFORM}/${ARCH}/${APP_NAME} > dist/release/pact-${PROJECT}-plugin-${PLATFORM}-${ARCH}.gz

prepare: generate_manifest

install_local: compile move_to_plugin_folder

move_to_plugin_folder:
	mkdir -p ${HOME}/.pact/plugins/pact-${PROJECT}-plugin-${PLUGIN_VERSION}
	mv ${APP_NAME} ${HOME}/.pact/plugins/pact-${PROJECT}-plugin-${PLUGIN_VERSION}
	cp pact-plugin.json ${HOME}/.pact/plugins/pact-${PROJECT}-plugin-${PLUGIN_VERSION}

generate_manifest:
	mkdir -p dist/release
	variable=${PLUGIN_VERSION}; jq --arg variable "$$variable" '.version = $$variable' pact-plugin.json > dist/release/pact-plugin.json
	cat dist/release/pact-plugin.json

compile_move: compile move_to_plugin_folder

PLATFORM 				:=
ARCH 				:=
ifeq '$(findstring ;,$(PATH))' ';'
	PLATFORM=win
	ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
		ARCH=arm64
	endif
	ifeq ($(PROCESSOR_ARCHITECTURE),x86)
		ARCH=x64
	endif
	UNAME_P := $(shell uname -m)
	ifeq ($(UNAME_P),x86_64)
		ARCH=x64
	endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		ARCH=arm64
	endif
	ifneq ($(filter aarch64%,$(UNAME_P)),)
		ARCH=arm64
	endif
else
	PLATFORM:=$(shell uname 2>/dev/null || echo Unknown)
	PLATFORM:=$(patsubst CYGWIN%,Cygwin,windows)
	PLATFORM:=$(patsubst MSYS%,MSYS,windows)
	PLATFORM:=$(patsubst MINGW%,MSYS,windows)
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		PLATFORM=linux
		ifeq ($(shell ldd /bin/ls >/dev/null 2>&1; echo $$?), 0)
			ldd_output=$(shell ldd /bin/ls)
			ifneq ($(findstring musl,$(ldd_output)),)
				PLATFORM=linux-musl
			else
				PLATFORM=linux
			endif
		endif
	endif
	ifeq ($(UNAME_S),Darwin)
		PLATFORM=osx
	endif
	UNAME_P := $(shell uname -m)
	ifeq ($(UNAME_P),x86_64)
		ARCH=x64
	endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		ARCH=arm64
	endif
	ifneq ($(filter aarch64%,$(UNAME_P)),)
		ARCH=arm64
	endif
endif


detect_os:
	@echo $(shell uname -s)
	@echo $(shell uname -m)
	@echo $(shell uname -p)
	@echo $(shell uname -p)
	@echo $(PLATFORM) $(ARCH)

x-plat: clean
	dotnet publish -o build/osx/arm64/${PROJECT} --arch arm64 --os osx
	dotnet publish -o build/osx/x64/${PROJECT} --arch x64 --os osx
	dotnet publish -o build/linux/arm64/${PROJECT} --arch arm64 --os linux
	dotnet publish -o build/linux/x64/${PROJECT} --arch x64 --os linux
	dotnet publish -o build/win/arm64/${PROJECT} --arch arm64 --os win
	dotnet publish -o build/win/x64/${PROJECT} --arch x64 --os win
	mkdir -p dist
	mkdir -p dist/release
	mkdir -p dist/linux/x86_64
	mkdir -p dist/windows/x86_64
	mkdir -p dist/osx/x86_64
	mkdir -p dist/osx/aarch64
	gzip -c build/osx/x64/${PROJECT}/${APP_NAME} > dist/release/pact-${PROJECT}-plugin-osx-x86_64.gz
	gzip -c build/osx/arm64/${PROJECT}/${APP_NAME} > dist/release/pact-${PROJECT}-plugin-osx-aarch64.gz
	gzip -c build/linux/x64/${PROJECT}/${APP_NAME} > dist/release/pact-${PROJECT}-plugin-linux-x86_64.gz
	gzip -c build/linux/arm64/${PROJECT}/${APP_NAME} > dist/release/pact-${PROJECT}-plugin-linux-aarch64.gz
	gzip -c build/win/x64/${PROJECT}/${APP_NAME}.exe > dist/release/pact-${PROJECT}-plugin-windows-x86_64.gz
	gzip -c build/win/arm64/${PROJECT}/${APP_NAME}.exe > dist/release/pact-${PROJECT}-plugin-windows-aarch64.gz