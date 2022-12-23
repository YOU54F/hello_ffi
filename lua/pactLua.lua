local ffi = require("ffi")
local pactLua =  {}
function pactLua(ffi)
    DIRECTIVES ={
        "#ifndef pact_ffi_h",
        "#define pact_ffi_h",
        "#include <stdarg.h>",
        "#include <stdbool.h>",
        "#include <stdint.h>",
        "#include <stdlib.h>",
        "#endif /* pact_ffi_h */"
    }
    FFI_HEADER_PATH="../pact.h"
        
    function inTable(tbl, item)
        for key, value in pairs(tbl) do
            if value == item then return key end
        end
        return false
    end                
    
    
    function processPactHeaderFile()
        local inf = assert(io.open(FFI_HEADER_PATH, "rw"), "Failed to open input file")
        local lines = ""
        while(true) do
        local line = inf:read("*line")
        if not line then break end
        if not inTable(DIRECTIVES,line) then
            lines = lines .. line .. "\n"
        end
        end
        inf:close()
    return lines
    end
    
    function loadFfiLibrary(ffi)
        dir = os.getenv("PWD") or io.popen("cd"):read()
        if ffi.os == "OSX" then
         return ffi.load(dir.."/../libpact_ffi.dylib")
        elseif ffi.os == "Windows" then
            return ffi.load(dir.."/../pact_ffi.dll")
        else
            return ffi.load(dir.."/../libpact_ffi.so")
        end
        end
    
    function loadFfiHeaders(ffi)
    return ffi.cdef(processPactHeaderFile())
    end
    
    function getPactFfiLib(ffi)
        loadFfiHeaders(ffi)
        lib = loadFfiLibrary(ffi)
    return lib
    end
     
return getPactFfiLib(ffi)
end

local pactLua = pactLua(ffi)
-- local version = ffi.string(pactLua.pactffi_version())
-- print(version)

return pactLua	
