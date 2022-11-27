import platform
import os
import sys
from pathlib import Path

IS_64 = sys.maxsize > 2 ** 32

DIRECTIVES =[
"#ifndef pact_ffi_h",
"#define pact_ffi_h",
"#include <stdarg.h>",
"#include <stdbool.h>",
"#include <stdint.h>",
"#include <stdlib.h>",
"#endif /* pact_ffi_h */"
            ]

# Build with cargo build in pact_ffi crate
FFI_HEADER_DIR= str(Path.cwd()) + '/'
FFI_LIB_DIR=str(Path.cwd()) + '/'

FFI_HEADER_PATH=f"{FFI_HEADER_DIR}pact.h"

def process_pact_header_file(file):
    with open(file, "r") as fp:
        lines = fp.readlines()

    pactfile = []

    for line in lines:
        if line.strip("\n") not in  DIRECTIVES:
            pactfile.append(line)

    return ''.join(pactfile)
    
def load_ffi_library(ffi):
    """Load the right library."""
    target_platform = platform.platform().lower()
    print(target_platform)
    print(platform.machine())

    if ("darwin" in target_platform or "macos" in target_platform) and ("aarch64" in platform.machine() or "arm64" in platform.machine()):
        libname = os.path.abspath(f"{FFI_LIB_DIR}/libpact_ffi.dylib")
        # the commented out lib names come from the distributed binaries
        # libname = os.path.abspath(f"{FFI_LIB_DIR}libpact_ffi-osx-aarch64-apple-darwin.dylib")
    elif "darwin" in target_platform or "macos" in target_platform:
        libname = os.path.abspath(f"{FFI_LIB_DIR}/libpact_ffi.dylib")
        # libname = os.path.abspath(f"{FFI_LIB_DIR}libpact_ffi-osx-x86_64.dylib")
    elif "linux" in target_platform and IS_64 and ("aarch64" in platform.machine() or "arm64" in platform.machine()):
        libname = os.path.abspath(f"{FFI_LIB_DIR}/libpact_ffi.so")
        # libname = os.path.abspath(f"{FFI_LIB_DIR}libpact_ffi-linux-aarch64.so")
    elif "linux" in target_platform and IS_64:
        libname = os.path.abspath(f"{FFI_LIB_DIR}/libpact_ffi.so")
        # libname = os.path.abspath(f"{FFI_LIB_DIR}libpact_ffi-linux-x86_64.so")
    elif 'windows' in target_platform:
        libname = os.path.abspath(f"{FFI_LIB_DIR}/pact_ffi.dll")
        # libname = os.path.abspath(f"{FFI_LIB_DIR}pact_ffi-windows-x86_64.dll")
    else:
        msg = ('Unfortunately, {} is not a supported platform. Only Linux,'
                ' Windows, and OSX are currently supported.').format(target_platform)
        raise Exception(msg)

    return ffi.dlopen(libname)

def load_ffi_headers(ffi):
    return ffi.cdef(process_pact_header_file(FFI_HEADER_PATH))

def get_ffi_lib(ffi):
    load_ffi_headers(ffi)
    lib = load_ffi_library(ffi)
    return lib