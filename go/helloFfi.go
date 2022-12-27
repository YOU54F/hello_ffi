package main

// #cgo CFLAGS: -g -I./..
// #cgo LDFLAGS: -lpact_ffi -L./..
// #include <stdlib.h>
// #include "../pact.h"
import "C"
import (
	"fmt"
)

func main() {
	version := C.pactffi_version()
	// fmt.Println(C.GoString(version))
	C.pactffi_logger_init()
	C.pactffi_logger_attach_sink(C.CString("stdout"), 3)
	C.pactffi_logger_apply()
	C.pactffi_log_message(C.CString("pact-go-ffi"), C.CString("INFO"), C.CString(fmt.Sprintf("hello from ffi version: %s", C.GoString(version))))
}
