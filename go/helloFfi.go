package main

// #cgo CFLAGS: -g -I./..
// #cgo LDFLAGS: -lpact_ffi -L./..
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


// https://github.com/golang/go/issues/51007

// *  Executing task: cd go; go build 

// # github.com/you54f/hello_ffi
// C:\Program Files\Go\pkg\tool\windows_amd64\link.exe: running gcc failed: exit status 1
// c:/programdata/chocolatey/lib/mingw/tools/install/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/12.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:\Users\grung\AppData\Local\Temp\go-link-3302340332\000005.o: in function `_cgo_preinit_init':
// \\_\_\runtime\cgo/gcc_libinit_windows.c:40: undefined reference to `__imp___iob_func'
// c:/programdata/chocolatey/lib/mingw/tools/install/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/12.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:\Users\grung\AppData\Local\Temp\go-link-3302340332\000005.o: in function `x_cgo_notify_runtime_init_done':
// \\_\_\runtime\cgo/gcc_libinit_windows.c:105: undefined reference to `__imp___iob_func'
// c:/programdata/chocolatey/lib/mingw/tools/install/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/12.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:\Users\grung\AppData\Local\Temp\go-link-3302340332\000005.o: in function `_cgo_beginthread':
// \\_\_\runtime\cgo/gcc_libinit_windows.c:149: undefined reference to `__imp___iob_func'
// c:/programdata/chocolatey/lib/mingw/tools/install/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/12.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: C:\Users\grung\AppData\Local\Temp\go-link-3302340332\000006.o: in function `x_cgo_thread_start':
// \\_\_\runtime\cgo/gcc_util.c:18: undefined reference to `__imp___iob_func'
// collect2.exe: error: ld returned 1 exit status
