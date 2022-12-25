Imports System
Imports System.Runtime.InteropServices

Module PactFfi
Declare Function PactFfiVersion Lib "pact_ffi" Alias "pactffi_version" () As IntPtr
Declare Function PactFfiLoggerInit Lib "pact_ffi" Alias "pactffi_logger_init" () As IntPtr
Declare Function PactFfiAttachSink Lib "pact_ffi" Alias "pactffi_logger_attach_sink" (sinkSpecifier As String, levelFilter As Int32) As Int32
Declare Function PactFfiLoggerApply Lib "pact_ffi" Alias "pactffi_logger_apply" () As IntPtr
Declare Function PactFfiLogMessage Lib "pact_ffi" Alias "pactffi_log_message" (source As String, logLevel As String, message As String) As IntPtr
   Sub Main()
    Dim version As String = Marshal.PtrToStringUTF8(PactFfiVersion())
   '  Console.WriteLine("Hello from Visual Basic, Ffi Version: {0}", version)
    PactFfiLoggerInit()
    PactFfiAttachSink("stdout",3)
    PactFfiLoggerApply()
    PactFfiLogMessage("pact-visual-basic","INFO","hello from ffi version: " + version)
   End Sub
End Module