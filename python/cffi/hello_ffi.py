from cffi import FFI
from register_ffi import get_ffi_lib

ffi = FFI()
lib = get_ffi_lib(ffi)                    # loads the entire C namespace
version_encoded = lib.pactffi_version()
ffi_version = ffi.string(version_encoded).decode('utf-8')

lib.pactffi_logger_init()
lib.pactffi_logger_attach_sink(b'stdout', 3)
# lib.pactffi_logger_attach_sink(b'stderr', 2)
lib.pactffi_logger_apply()
lib.pactffi_log_message(b'pact-python-cffi', b'INFO', b'hello from ffi version: ' + ffi.string(version_encoded))

# import json
# contents ={
#         "provider": {
#           "name": "Alice Service"
#         },
#         "consumer": {
#           "name": "Consumer"
#         },
#         "interactions": [
#           {
#             "description": "a retrieve Mallory request",
#             "request": {
#               "method": "GET",
#               "path": "/mallory",
#               "query": "name=ron&status=good"
#             },
#             "response": {
#               "status": 200,
#               "headers": {
#                 "Content-Type": "text/html"
#               },
#               "body": "That is some good Mallory."
#             }
#           }
#         ],
#         "metadata": {
#           "pact-specification": {
#             "version": "1.0.0"
#           },
#           "pact-python": {
#             "version": "1.0.0",
#             "ffi": ffi_version
#           }
#         }
#       }

# ## Load pact into Mock Server and start
# mock_server_port = lib.pactffi_create_mock_server(ffi.new("char[]", json.dumps(contents).encode('ascii')) , b'127.0.0.1:4432',0)
# print(f"Mock server started: {mock_server_port}")
# result = lib.pactffi_mock_server_matched(mock_server_port)
# print(f"Pact - Got matching client requests: {result}")
# PACT_FILE_DIR='./pacts'
# print(f"Writing pact file to {PACT_FILE_DIR}")
# res_write_pact = lib.pactffi_write_pact_file(mock_server_port, PACT_FILE_DIR.encode('ascii'), False)
# print(f"Pact file writing results: {res_write_pact}")
# lib.pactffi_cleanup_mock_server(mock_server_port)
