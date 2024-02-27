#!/usr/bin/swift -import-objc-header pact.h -L${PWD} -lpact_ffi
import Foundation

let app_name: String = "pact-swift-ffi"
let version: String? = String(validatingUTF8: pactffi_version())
print("Hello from Pact Swift FFI: \(version!)")

// Setup Loggers
pactffi_logger_init()
pactffi_logger_attach_sink("stdout", LevelFilter_Info)
pactffi_logger_apply()
pactffi_log_message(app_name, "INFO", "Hello from \(version!)")

// Setup gRPC Interaction
let fileManager = FileManager.default
let currentPath = fileManager.currentDirectoryPath

class GrpcPact: Codable {
  let pactProto, pactProtoService, pactContentType: String
  let request: Request
  let response: Response

  enum CodingKeys: String, CodingKey {
    case pactProto = "pact:proto"
    case pactProtoService = "pact:proto-service"
    case pactContentType = "pact:content-type"
    case request, response
  }

  init(
    pactProto: String, pactProtoService: String, pactContentType: String, request: Request,
    response: Response
  ) {
    self.pactProto = pactProto
    self.pactProtoService = pactProtoService
    self.pactContentType = pactContentType
    self.request = request
    self.response = response
  }
}

class Request: Codable {
  let rectangle: Rectangle

  init(rectangle: Rectangle) {
    self.rectangle = rectangle
  }
}

class Rectangle: Codable {
  let length, width: String

  init(length: String, width: String) {
    self.length = length
    self.width = width
  }
}

class Response: Codable {
  let value: [String]

  init(value: [String]) {
    self.value = value
  }
}

let grpcPact = GrpcPact(
  pactProto: "\(currentPath)/proto/area_calculator.proto",
  pactProtoService: "Calculator/calculateOne",
  pactContentType: "application/protobuf",
  request:
    Request(
      rectangle: Rectangle(
        length: "matching(number, 3)",
        width: "matching(number, 4)")),
  response:
    Response(value: ["matching(number, 12)"]))

let jsonEncoder = JSONEncoder()
let grpcPactData = try jsonEncoder.encode(grpcPact)
let contents = String(data: grpcPactData, encoding: .utf8)
print(contents!)

// Setup pact for testing
let pact: PactHandle?? = pactffi_new_pact("grpc-consumer-swift", "area-calculator-provider")
pactffi_log_message(app_name, "INFO", "Pact \(pact!!)")
pactffi_with_pact_metadata(pact!!, app_name, "ffi", version)
let message_pact: InteractionHandle?? = pactffi_new_sync_message_interaction(
  pact!!, "A gRPC calculateOne request")
pactffi_log_message(app_name, "INFO", "pactffi_new_sync_message_interaction \(message_pact!!)")
pactffi_with_specification(pact!!, PactSpecification_V4)

// Start mock server
pactffi_log_message(app_name, "INFO", "using plugin")
pactffi_using_plugin(pact!!, "protobuf", "0.3.14")
pactffi_log_message(app_name, "INFO", "got plugin, setting interaction contents: \(contents!)")
pactffi_interaction_contents(message_pact!!, InteractionPart_Request, "application/grpc", contents!)
pactffi_log_message(app_name, "INFO", "set interaction contents")

pactffi_log_message(app_name, "INFO", "pactffi_new_sync_message_interaction \(message_pact!!)")
let mock_server_port = pactffi_create_mock_server_for_transport(pact!!, "0.0.0.0", 0, "grpc", nil)
pactffi_log_message(
  app_name, "INFO", "pactffi_create_mock_server_for_transport \(mock_server_port)")

// check results and write pact
let matched = pactffi_mock_server_matched(mock_server_port)
pactffi_log_message(app_name, "INFO", "pactffi_mock_server_matched \(matched)")

if matched == true {
  let PACT_FILE_DIR = "./pacts"
  let res_write_pact = pactffi_write_pact_file(mock_server_port, PACT_FILE_DIR, false)
  pactffi_log_message(app_name, "INFO", "pactffi_write_pact_file \(res_write_pact)")
} else {
  let mismatches: UnsafeMutablePointer<Int8>?? = pactffi_mock_server_mismatches(mock_server_port)
  let mismatchText = String(validatingUTF8: mismatches!!) ?? "Failed to get mismatches"
  pactffi_log_message(app_name, "INFO", "pactffi_mock_server_mismatches \(mismatchText)")
}

let pactffi_cleanup_mock_server_result = pactffi_cleanup_mock_server(mock_server_port)
pactffi_log_message(
  app_name, "INFO", "pactffi_cleanup_mock_server \(pactffi_cleanup_mock_server_result)")
pactffi_cleanup_plugins(pact!!)
pactffi_log_message(app_name, "INFO", "pactffi_cleanup_plugins done")
