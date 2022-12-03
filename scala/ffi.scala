using lib "fr.hammons::slinc-runtime:0.1.1-72-1cedff"

import fr.hammons.slinc.runtime.{*,given}

case class div_t(quot: CInt, rem: CInt) derives Struct

object MyLib derives Library:
  def abs(i: CInt): CInt = Library.binding
  def div(numer: CInt, denom: CInt): div_t = Library.binding

@main def program = 
  println(MyLib.abs(-5)) // prints 5
  println(MyLib.div(5,2)) 