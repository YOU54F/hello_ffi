#!/bin/bash -eu
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)" # Figure out where the script is running
. "${LIB_DIR}/robust-bash.sh"
. "${LIB_DIR}/download-file.sh"

require_binary curl
require_binary gunzip

require_env_var PLUGIN_CLI_VERSION

BASEURL=https://github.com/you54f/pact-plugins/releases/download
PLUGIN_CLI_DIR="${HOME}/.pact/cli/plugin"

if [[ $(find "${PLUGIN_CLI_DIR}" -name "${PLUGIN_CLI_VERSION}*") ]]; then
  log "Skipping download of plugin cli ${PLUGIN_CLI_VERSION}, if it exists"
  exit 0
fi

warn "Cleaning plugin directory $PLUGIN_CLI_DIR"
rm -rf "${PLUGIN_CLI_DIR:?}"
mkdir -p $PLUGIN_CLI_DIR

function download_plugin_cli_file {
  if [ -z "${1:-}" ]; then
    error "${FUNCNAME[0]} requires the filename to download"
    exit 1
  fi
  if [ -z "${2:-}" ]; then
    error "${FUNCNAME[0]} requires the output filename to download"
    exit 1
  fi
  PLUGIN_CLI_FILENAME="$1"
  OUTPUT_FILENAME="$2"

  URL="${BASEURL}/pact-plugin-cli-${PLUGIN_CLI_VERSION}/${PLUGIN_CLI_FILENAME}"
  DOWNLOAD_LOCATION="$PLUGIN_CLI_DIR/${OUTPUT_FILENAME}"

  log "Downloading plugin cli $PLUGIN_CLI_VERSION for $PLUGIN_CLI_FILENAME"
  download_to "$URL" "$DOWNLOAD_LOCATION"
  log " ... downloaded to '$DOWNLOAD_LOCATION'"
}

function download_plugin_cli {
  if [ -z "${1:-}" ]; then
    error "${FUNCNAME[0]} requires the environment filename suffix"
    exit 1
  fi
  SUFFIX="$1"
  PREFIX="${2:-}"
  OUTPUT_FILENAME="${3:-}"
  OS="${4:-}"
  log "${PREFIX}pact_ffi-$SUFFIX" "${OUTPUT_FILENAME}"

  download_plugin_cli_file "${PREFIX}pact-plugin-cli-$SUFFIX" "${OUTPUT_FILENAME}"
  log " ... unzipping '$DOWNLOAD_LOCATION'"
  gunzip "${DOWNLOAD_LOCATION}"


  case ${OS} in
  win32)
  "$PLUGIN_CLI_DIR"/pact-plugin-cli.exe --help
  ;;
  *)
  chmod +x "$PLUGIN_CLI_DIR"/pact-plugin-cli
  "$PLUGIN_CLI_DIR"/pact-plugin-cli --help
  ;;
  esac

}

detected_os=$(uname -sm)
echo detected_os = $detected_os
case ${detected_os} in
'Darwin arm64')
    echo "downloading of osx aarch64 FFI libs"
    os='osx-aarch64'
    download_plugin_cli "osx-aarch64.gz" "" "pact-plugin-cli.gz" "${os}"
    ;;
'Darwin x86' | 'Darwin x86_64' | "Darwin"*)
    echo "downloading of osx x86_64 FFI libs"
    os='osx-x86_64'
    download_plugin_cli "osx-x86_64.gz" "" "pact-plugin-cli.gz" "${os}"
    ;;
"Linux aarch64"* | "Linux arm64"*)
    echo "downloading of linux aarch64 FFI libs"
    if ldd /bin/ls >/dev/null 2>&1; then
        ldd_output=$(ldd /bin/ls)
        case "$ldd_output" in
            *musl*) 
                os='linux-aarch64-musl'
                download_plugin_cli "linux-aarch64-musl.gz" "" "pact-plugin-cli.gz" "${os}"
                ;;
            *) 
                os='linux-aarch64'
                download_plugin_cli "linux-aarch64.gz" "" "pact-plugin-cli.gz" "${os}"
                ;;
        esac
    else
      os='linux-aarch64'
      download_plugin_cli "linux-aarch64.gz" "" "pact-plugin-cli.gz" "${os}"
    fi
    ;;
'Linux x86_64' | "Linux"*)
    echo "downloading of linux x86_64 FFI libs"
    if ldd /bin/ls >/dev/null 2>&1; then
        ldd_output=$(ldd /bin/ls)
        case "$ldd_output" in
            *musl*) 
                os='linux-x86_64-musl'
                download_plugin_cli "linux-x86_64-musl.gz" "" "pact-plugin-cli.gz" "${os}"
                ;;
            *) 
                os='linux-x86_64'
                download_plugin_cli "linux-x86_64.gz" "" "pact-plugin-cli.gz" "${os}"
                ;;
        esac
    else
      os='linux-x86_64'
      download_plugin_cli "linux-x86_64.gz" "" "pact-plugin-cli.gz" "${os}"
    fi
    ;;
"Windows"* | "MINGW64"*)
    echo "downloading of windows x86_64 FFI libs"
    os='win32'
    download_plugin_cli "windows-x86_64.exe.gz" "" "pact-plugin-cli.exe.gz" "${os}"
    ;;
  *)
  echo "Sorry, you'll need to install the pact-ruby-standalone manually."
  echo "or add your os to the list"
  exit 1
    ;;
esac


# Write readme in the plugin folder
# cat << EOF > "$PLUGIN_CLI_DIR/README.md"
# # Pact plugin cli

# This folder is automatically populated during build by /script/download-plugin-cli.sh
# EOF
