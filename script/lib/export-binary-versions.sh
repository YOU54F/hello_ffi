#!/bin/bash -eu
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)" # Figure out where the script is running
PROJECT_DIR="${LIB_DIR}"/../../
export FFI_VERSION=v$(cat $PROJECT_DIR/FFI_VERSION)
export PLUGIN_CLI_VERSION=v0.0.1