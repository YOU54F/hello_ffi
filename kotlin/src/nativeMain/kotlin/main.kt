import kotlinx.cinterop.*
import pact.*

fun main(args: Array<String>) {
    val version = pactffi_version()
    if (version != null) {
            println("hello from pact-kotlin - ffi version: ${(version)?.toKString()}")
    }
}