#!/usr/bin/env julia
using Libdl

libname = "pact_ffi"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

lib = Libdl.dlopen(libname)
c_pactffi_version = Libdl.dlsym(lib, :pactffi_version)

function getFFIVersion()
    s = ccall(
        c_pactffi_version,
        Cstring, (),
        )
    out = unsafe_string(s)
end

version = getFFIVersion()
println(version)