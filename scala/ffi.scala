using lib "fr.hammons::slinc-runtime:0.1.1-72-1cedff"

import fr.hammons.slinc.runtime.{*,given}

case class div_t(quot: Int, rem: Int) derives Struct 

object MyLib derives Library:
  def div(numer: Int, denom: Int): div_t = Library.binding

@main def calc = 
  val (quot, rem) = Tuple.fromProduct(MyLib.div(5,2))
  println(s"Got a quotient of $quot and a remainder of $rem")