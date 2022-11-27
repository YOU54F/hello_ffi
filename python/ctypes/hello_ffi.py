import ctypes
import platform
import sys
IS_64 = sys.maxsize > 2 ** 32
from pathlib import Path
FFI_LIB_DIR=str(Path.cwd())
target_platform = platform.platform().lower()
if "darwin" in target_platform or "macos" in target_platform:
    lib_file = "libpact_ffi.dylib"
elif "linux" in target_platform and IS_64:
    lib_file = "libpact_ffi.so"
elif 'windows' in target_platform:
    lib_file = "pact_ffi.dll"
else:
    msg = ('Unfortunately, {} is not a supported platform. Only Linux,'
            ' Windows, and OSX are currently supported.').format(target_platform)
    raise Exception(msg)
libc = ctypes.CDLL(f"{FFI_LIB_DIR}/{lib_file}")
libc.pactffi_version.restype = ctypes.c_char_p
version = libc.pactffi_version()    
libc.pactffi_logger_init()
libc.pactffi_logger_attach_sink(b'stdout', 5)
libc.pactffi_logger_attach_sink(b'stderr', 5)
libc.pactffi_logger_apply()
libc.pactffi_log_message(b'pact-python-ctypes', b'INFO', b'hello from ffi version: ' + version)