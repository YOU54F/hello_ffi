#!/usr/bin/env utop
#require "ctypes.foreign";;
#require "ctypes.top";;

open Ctypes
open PosixTypes
open Foreign

(* TODO: library needs to be .so for unix / ocaml cannot detect between linux/darwin *)

let pact = Dl.dlopen ~filename: "libpact_ffi.dylib" ~flags:[Dl.RTLD_LAZY; Dl.RTLD_GLOBAL];;

let pactffi_version = foreign "pactffi_version" (void @-> returning string)
let pactffi_logger_init = foreign "pactffi_logger_init" (void @-> returning void)
let pactffi_logger_attach_sink = foreign "pactffi_logger_attach_sink" (string @-> int @-> returning int)
let pactffi_logger_apply = foreign "pactffi_logger_apply" (void @-> returning void)
let pactffi_log_message = foreign "pactffi_log_message" (string @-> string @-> string @-> returning void)

let v = pactffi_version();;
(* print_string ("Hello from OCaml, ffi version: "^ v ^ "\n");; *)
pactffi_logger_init();;
pactffi_logger_attach_sink "stdout" 3;;
pactffi_logger_apply();;
pactffi_log_message "pact-ocaml" "INFO" ("hello from ffi version: "^ v);;