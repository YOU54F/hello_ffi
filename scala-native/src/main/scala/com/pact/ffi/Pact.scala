package com.baeldung.native

import scalanative._
import scala.scalanative.unsafe._
import scala.scalanative.libc.string

object Pact {
  def version():String = {
      println(fromCString(pact.pactffi_version())) // Prints ScalaNative
      println("Hello from Scala Native, pact ffi version: "+fromCString(pact.pactffi_version())) // Prints ScalaNative
      return fromCString(pact.pactffi_version());
  }
  def helloPactFfi() = {
    pact.pactffi_logger_init()
    pact.pactffi_logger_attach_sink(c"stdout", 3)
    pact.pactffi_logger_apply()
    val welcome = "hello from ffi version: "
    val message: CString = Zone { implicit z => string.strcat(toCString(welcome), pact.pactffi_version()) }
    pact.pactffi_log_message(c"pact-scala-native",c"INFO",message)
  }
  @extern
  @link("pact_ffi")
  object pact {
    def pactffi_version(): CString = extern
    def pactffi_logger_init():Void = extern
    def pactffi_logger_attach_sink(sinkSpecifier:CString, levelFilter:Int): CString = extern
    def pactffi_logger_apply(): Int = extern
    def pactffi_log_message(source:CString,logLevel:CString,message:CString): CString = extern
  }

  def main(args: Array[String]): Unit = {
    version
    helloPactFfi
  }

}
