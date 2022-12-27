import kotlinx.cinterop.*
import pact.*

fun main(args: Array<String>) {
    val version = pactffi_version()
    // if (version != null) {
    //         println("hello from pact-kotlin - ffi version: ${(version)?.toKString()}")
    // }
    pactffi_logger_init()
    pactffi_logger_attach_sink("stdout", LevelFilter.LevelFilter_Info)
    pactffi_logger_apply()
    pactffi_log_message("pact-kotlin","INFO", "hello from ffi version: " + version?.toKString())
}