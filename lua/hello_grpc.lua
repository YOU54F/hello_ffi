
pactLua = require("pactLua")
local ffi = require("ffi")
JSON = require("JSON")
local version = ffi.string(lib.pactffi_version())
local appName = ffi.string(lib.pactffi_version())

-- Setup Loggers
lib.pactffi_logger_init()
lib.pactffi_logger_attach_sink('stdout', 3)
lib.pactffi_logger_attach_sink('stderr', 2)
lib.pactffi_logger_apply()
lib.pactffi_log_message(appName, 'INFO', 'hello from ffi version: ' .. ffi.string(lib.pactffi_version()))


dir = os.getenv("PWD") or io.popen("cd"):read()
pact_contents =  {
    ["pact:proto"] = dir.."/../proto/area_calculator.proto",
    ["pact:proto-service"] = "Calculator/calculateOne",
    ["pact:content-type"] = "application/protobuf",
    request = {
      rectangle = {
        length = "matching(number, 3)",
        width = "matching(number, 4)"
      }
    },
    response = {
      value = { "matching(number, 12)" }
    }
  }
local contents = JSON:encode(pact_contents)

lib.pactffi_log_message(appName, 'INFO', "Loading pact contents: "..contents)

-- Setup pact for testing
pact = lib.pactffi_new_pact('grpc-consumer-lua', 'area-calculator-lua')
lib.pactffi_with_pact_metadata(pact, 'pact-lua', 'ffi', version)
message_pact = lib.pactffi_new_sync_message_interaction(pact, 'A gRPC calculateOne request')
lib.pactffi_with_specification(pact, 5)


-- Start mock server
lib.pactffi_using_plugin(pact, 'protobuf', '0.3.14')
lib.pactffi_interaction_contents(message_pact, 0, 'application/grpc',contents)
mock_server_port = lib.pactffi_create_mock_server_for_transport(pact , '0.0.0.0',0,'grpc',ffi.cast("void *", 0))
lib.pactffi_log_message(appName, 'INFO', "Mock server started: "..mock_server_port)

-- Make our client call
--  expected_response = 12.0
--  response = get_rectangle_area(f"localhost:{mock_server_port}")
--  print(f"Client response: {response}")
--  print(f"Client response - matched expected: {response == expected_response}")

result = lib.pactffi_mock_server_matched(mock_server_port)
if result then
    lib.pactffi_log_message(appName, 'INFO', "Pact - Got matching client requests: "..result)
    PACT_FILE_DIR='./pacts'
    lib.pactffi_log_message(appName, 'INFO', "Writing pact file to "..PACT_FILE_DIR)
    res_write_pact = lib.pactffi_write_pact_file(mock_server_port, PACT_FILE_DIR, false)
    lib.pactffi_log_message(appName, 'INFO', "Pact file writing results "..res_write_pact)
else
    print('pactffi_mock_server_matched did not match')
    lib.pactffi_log_message(appName, 'INFO', "pactffi_mock_server_matched did not match")
    mismatchers = lib.pactffi_mock_server_mismatches(mock_server_port)
    if mismatchers then
        lib.pactffi_log_message(appName, 'INFO', "pactffi_mock_server_matched did not match"..ffi.string(mismatchers))
    end
end
--  Cleanup
lib.pactffi_cleanup_mock_server(mock_server_port)
lib.pactffi_cleanup_plugins(pact)
