//go:build darwin || linux || windows

package main

func main() {

	print(pactffi_version())
	pactffi_log_to_stdout(4)
	// pactffi_log_to_file("pact.log", 5)

	var verifier_handle = pactffi_verifier_new_for_application("pact-purego", "0.0.1")
	pactffi_verifier_set_provider_info(verifier_handle, "grpc-provider", "http", "localhost", 1234, "/")
	pactffi_verifier_add_file_source(verifier_handle, "no_pact.json")
	// pactffi_verifier_add_file_source(verifier_handle, "pact.json")
	// pactffi_verifier_add_file_source(verifier_handle, "../pacts/Consumer-Alice Service.json")
	// pactffi_verifier_add_file_source(verifier_handle, "../pacts/grpc-consumer-perl-area-calculator-provider.json")
	pactffi_verifier_execute(verifier_handle)
	pactffi_verifier_shutdown(verifier_handle)
}
