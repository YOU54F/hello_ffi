#!/usr/bin/env julia
using Libdl

libname = "pact_ffi"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

lib = Libdl.dlopen(libname)
c_pactffi_version = Libdl.dlsym(lib, :pactffi_version)
c_pactffi_logger_init = Libdl.dlsym(lib, :pactffi_logger_init)
c_pactffi_logger_attach_sink = Libdl.dlsym(lib, :pactffi_logger_attach_sink)
c_pactffi_logger_apply = Libdl.dlsym(lib, :pactffi_logger_apply)
c_pactffi_log_message = Libdl.dlsym(lib, :pactffi_log_message)

function getFFIVersion()
    s = ccall(
        c_pactffi_version,
        Cstring, (),
        )
    out = unsafe_string(s)
end

version = getFFIVersion()

ccall(
        c_pactffi_logger_init,
        Cvoid, (),
        )

ccall(
        c_pactffi_logger_attach_sink,
        Cint, (Cstring,Cint),"stdout", 5
        )

ccall(
        c_pactffi_logger_apply,
        Cvoid, (),
        )

ccall(
        c_pactffi_log_message,
        Cvoid, (Cstring,Cstring,Cstring),"pact-julia-ffi","INFO","hello from ffi version: $(version)"
        )