using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace PInvokeTest
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.OutputEncoding = System.Text.Encoding.UTF8;
            var version = Marshal.PtrToStringAnsi(pactffi_version());
            // Console.WriteLine("Hello, from C#. pact ffi version: {0} ", version);
            pactffi_logger_init();
            pactffi_logger_attach_sink("stdout", 3);
            pactffi_logger_apply();
            pactffi_log_message("pact-csharp", "info", $"hello from ffi version: {version}");

        }

        [DllImport("pact_ffi")]
        private static extern IntPtr pactffi_version();
        [DllImport("pact_ffi")]
        private static extern void pactffi_logger_init();
        [DllImport("pact_ffi")]
        private static extern Int32 pactffi_logger_attach_sink( string sinkSpecifier, Int32 levelFilter);
        [DllImport("pact_ffi")]
        private static extern void pactffi_logger_apply();
        [DllImport("pact_ffi")]
        private static extern void pactffi_log_message(string source,string logLevel,string message);
    }
}