with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Ada.Text_IO;  use Ada.Text_IO;

procedure HelloFfi is

   type LevelFilter is 
     (LevelFilter_Off,
      LevelFilter_Error,
      LevelFilter_Warn,
      LevelFilter_Info,
      LevelFilter_Debug,
      LevelFilter_Trace)
   with Convention => C;  -- ../pact.h:69

   function pactffi_version return Interfaces.C.Strings.chars_ptr
     with
       Import        => True,
       Convention    => C;


   procedure pactffi_logger_init  -- ../pact.h:571
   with Import => True, 
        Convention => C, 
        External_Name => "pactffi_logger_init";

    function pactffi_logger_attach_sink (sink_specifier : Interfaces.C.Strings.chars_ptr; level_filter : LevelFilter) return int  -- ../pact.h:608
   with Import => True, 
        Convention => C, 
        External_Name => "pactffi_logger_attach_sink";


   function pactffi_logger_apply return int  -- ../pact.h:618
   with Import => True, 
        Convention => C, 
        External_Name => "pactffi_logger_apply";

   procedure pactffi_log_message
     (source : Interfaces.C.Strings.chars_ptr;
      log_level : Interfaces.C.Strings.chars_ptr;
      message : Interfaces.C.Strings.chars_ptr)  -- ../pact.h:436
   with Import => True, 
        Convention => C, 
        External_Name => "pactffi_log_message";

   V : Interfaces.C.Strings.chars_ptr;
   P : Int;
   R : Int;

begin
   V := pactffi_version;
   -- Put_Line ("Hello from Ada. Ffi version: " & Value (V));
   pactffi_logger_init;
   R := pactffi_logger_attach_sink(V,LevelFilter_Info);
   P := pactffi_logger_apply;
   pactffi_log_message( New_String ("pact-ada"),New_String ("INFO"),New_String("hello from ffi version: " & Value (V)));
end HelloFfi;
