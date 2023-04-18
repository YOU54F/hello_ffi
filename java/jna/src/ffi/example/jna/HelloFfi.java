package msk.example.jna;

import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.Pointer;
import com.sun.jna.Structure;
import com.sun.jna.Platform;

public class HelloFfi {

    public interface PactFfi extends Library {
        PactFfi INSTANCE = (PactFfi) Native.load((Platform.isWindows() ? "pact_ffi.dll" : Platform.isLinux() ? "libpact_ffi.so" : "libpact_ffi.dylib"),
                PactFfi.class);

        String pactffi_version();

        Void pactffi_logger_init();

        int pactffi_logger_attach_sink(String sinkSpecifier, int LevelFilter);

        Void pactffi_logger_apply();

        Void pactffi_log_message(String source, String logLevel, String message);
    }

    public static void main(String[] args) {
        var version = PactFfi.INSTANCE.pactffi_version();
        PactFfi.INSTANCE.pactffi_logger_init();
        PactFfi.INSTANCE.pactffi_logger_attach_sink("stdout",3);
        PactFfi.INSTANCE.pactffi_logger_apply();
        PactFfi.INSTANCE.pactffi_log_message("pact-java-jna","INFO","hello from ffi version: "+version.toString());
    }
}