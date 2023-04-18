
pactLua = require("pactLua")
local ffi = require("ffi")

local version = ffi.string(pactLua.pactffi_version())

pactLua.pactffi_logger_init()
pactLua.pactffi_logger_attach_sink('stdout', 3)
-- pactLua.pactffi_logger_attach_sink('stderr', 2)
pactLua.pactffi_logger_apply()
pactLua.pactffi_log_message('pact-lua-ffi', 'INFO', 'hello from ffi version: ' .. ffi.string(pactLua.pactffi_version()))