#!/bin/bash -eu
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)" # Figure out where the script is running
PROJECT_DIR="${LIB_DIR}"/../../
export FFI_VERSION=v0.3.14
export PLUGIN_CLI_VERSION=v0.0.1