Imports System
Imports System.Runtime.InteropServices
Imports System.Text

Module PactFfi
Declare Function PactFfiVersion Lib "pact_ffi" Alias "pactffi_version" () As IntPtr
Declare Function PactFfiLoggerInit Lib "pact_ffi" Alias "pactffi_logger_init" () As IntPtr
Declare Function PactFfiAttachSink Lib "pact_ffi" Alias "pactffi_logger_attach_sink" (sinkSpecifier As String, levelFilter As Int32) As Int32
Declare Function PactFfiLoggerApply Lib "pact_ffi" Alias "pactffi_logger_apply" () As IntPtr
Declare Function PactFfiLogMessage Lib "pact_ffi" Alias "pactffi_log_message" (source As String, logLevel As String, message As String) As IntPtr


   Sub Main()
   
   ' https://www.visualbasicplanet.info/dotnet-interoperability/the-marshal-class.html
   ' windows not happy with PtrToStringUTF8
   Dim utf8 As New UTF8Encoding()
    Dim version As String = If(My.Computer.Info.OSPlatform = "Win32NT", Marshal.PtrToStringAnsi(PactFfiVersion()), Marshal.PtrToStringAuto(PactFfiVersion()))
    Console.WriteLine("Hello from Visual Basic, Ffi Version: {0}", version)
    PactFfiLoggerInit()
    PactFfiAttachSink("stdout",3)
    PactFfiLoggerApply()
    PactFfiLogMessage("pact-visual-basic","INFO","hello from ffi version: " + version)
   End Sub
End Module