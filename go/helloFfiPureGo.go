package main

import (
	"fmt"
	"runtime"

	"github.com/ebitengine/purego"
)

func getSystemLibrary() string {
	switch runtime.GOOS {
	case "darwin":
		return "libpact_ffi.dylib"
	case "linux":
		return "libpact_ffi.so"
	default:
		panic(fmt.Errorf("GOOS=%s is not supported", runtime.GOOS))
	}
}

func main() {
	libpact_ffi, err := purego.Dlopen(getSystemLibrary(), purego.RTLD_NOW|purego.RTLD_GLOBAL)
	if err != nil {
		panic(err)
	}

	// General Functions
	var pactffi_version func() string
	purego.RegisterLibFunc(&pactffi_version, libpact_ffi, "pactffi_version")

	// General Check
	print(pactffi_version())

	// Logging Functions
	var pactffi_log_to_stdout func(int) int
	purego.RegisterLibFunc(&pactffi_log_to_stdout, libpact_ffi, "pactffi_log_to_stdout")
	var pactffi_log_to_buffer func(int) int
	purego.RegisterLibFunc(&pactffi_log_to_buffer, libpact_ffi, "pactffi_log_to_buffer")
	var pactffi_log_to_file func(string, int) int
	purego.RegisterLibFunc(&pactffi_log_to_file, libpact_ffi, "pactffi_log_to_file")

	// Logging Check
	pactffi_log_to_stdout(4)
	// pactffi_log_to_file("pact.log", 5)

	// Verifier Functions
	var pactffi_verifier_new_for_application func(string, string) uintptr
	purego.RegisterLibFunc(&pactffi_verifier_new_for_application, libpact_ffi, "pactffi_verifier_new_for_application")
	var pactffi_verifier_shutdown func(uintptr)
	purego.RegisterLibFunc(&pactffi_verifier_shutdown, libpact_ffi, "pactffi_verifier_shutdown")
	var pactffi_verifier_set_provider_info func(uintptr, string, string, string, int, string)
	purego.RegisterLibFunc(&pactffi_verifier_set_provider_info, libpact_ffi, "pactffi_verifier_set_provider_info")
	var pactffi_verifier_execute func(uintptr) int
	purego.RegisterLibFunc(&pactffi_verifier_execute, libpact_ffi, "pactffi_verifier_execute")
	var pactffi_verifier_add_file_source func(uintptr, string)
	purego.RegisterLibFunc(&pactffi_verifier_add_file_source, libpact_ffi, "pactffi_verifier_add_file_source")

	// Verifier Check
	var verifier_handle = pactffi_verifier_new_for_application("pact-purego", "0.0.1")
	pactffi_verifier_set_provider_info(verifier_handle, "grpc-provider", "http", "localhost", 1234, "/")
	pactffi_verifier_add_file_source(verifier_handle, "no_pact.json")
	// pactffi_verifier_add_file_source(verifier_handle, "pact.json")
	// pactffi_verifier_add_file_source(verifier_handle, "../pacts/Consumer-Alice Service.json")
	// pactffi_verifier_add_file_source(verifier_handle, "../pacts/grpc-consumer-perl-area-calculator-provider.json")
	pactffi_verifier_execute(verifier_handle)
	pactffi_verifier_shutdown(verifier_handle)
}
