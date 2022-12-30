import static java.lang.foreign.MemorySession.*;
import static org.pact.pact_h.*;
public class Panama {
    public static void main(String[] args) {
          var version =  pactffi_version();
        //   System.out.println(version.getUtf8String(0));
          pactffi_logger_init();
          var memorySession =  openConfined();
          var sinkSpecifier = memorySession.allocateUtf8String("stdout");
          pactffi_logger_attach_sink(sinkSpecifier, 5);
          pactffi_logger_apply();
          var source = memorySession.allocateUtf8String("pact-java-panama");
          var logLevel = memorySession.allocateUtf8String("INFO");
          var message = memorySession.allocateUtf8String("hello from ffi version: " + version.getUtf8String(0));
          pactffi_log_message(source,logLevel,message);
    }
}

// To Generate:

// jextract-19/bin/jextract \
// --output src \
// -t org.pact \
// -I /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include \
// -l$PWD/../../libpact_ffi.dylib ../../pact.h


// To Run:

// java -classpath ./src --enable-native-access=ALL-UNNAMED --enable-preview --source 19 Panama.java