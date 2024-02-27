package msk.example.jna;

import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.Pointer;
import com.sun.jna.Structure;
import com.sun.jna.Platform;


public class Hello {

    public interface CLibrary extends Library {
        CLibrary INSTANCE = (CLibrary)
            Native.load((Platform.isWindows() ? "pactffi.dll" : Platform.isLinux() ?  "libpact_ffi.so" : "libpact_ffi.dylib"),
                                CLibrary.class);
        String pactffi_version();
    }

    public static void main(String[] args) {
        var version = CLibrary.INSTANCE.pactffi_version();
        System.out.println(version.toString()); 
    }
}