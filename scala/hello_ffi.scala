using lib "io.gitlab.mhammons::slinc:0.1.1"
import io.gitlab.mhammons.slinc.*

object Testlib extends Library(Location.Local("/Users/saf/dev/you54f/hello_ffi/libpact_ffi.dylib")):
   def pactffiVersion():String = accessNative[String]

@main def program = 
  println(Testlib.pactffiVersion())
