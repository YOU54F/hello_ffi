import io.gitlab.mhammons.slinc.*

object Testlib extends Library(Location.Local("/Users/saf/dev/you54f/hello_ffi/libpact_ffi.so")):
   def pactffiVersion():String = accessNative[String]

@main def hello: Unit = 
  println("Hello world!")
  println(msg)
  // println(Testlib.pactffiVersion())

def msg = "I was compiled by Scala 3. :)"

