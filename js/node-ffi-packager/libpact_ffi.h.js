/*
 * This file was automatically generated. It is better to run the generator again, than to manually edit.
 *
 * @ffi-packager/ffi-generate v2.0.2
 * - git commit 39d91ff-dirty on branch main
 * - Apple clang version 14.0.0 (clang-1400.0.29.102)
 * https://github.com/node-ffi-packager/node-ffi-generate
 *
 * File:
 * - Name: "pact.h"
 * - SHA256: 90a82145f0e77667b5fdc358d34d0bd42a711f2fa6a48db6bde2f8a847fccd8c
 *
 * Generator options:
 * - Library: "libpact_ffi"
 * - Single file: false
 * - Prefixes: []
 * - Compiler arguments: []
 */

const FFI = require("ffi-napi");
const ref = require("ref-napi");
const ArrayType = require("ref-array-di")(ref);
const Struct = require("ref-struct-di")(ref);
const Union = require("ref-union-di")(ref);

const constants = {
  ExpressionValueType: {
    ExpressionValueType_Unknown: 0,
    ExpressionValueType_String: 1,
    ExpressionValueType_Number: 2,
    ExpressionValueType_Integer: 3,
    ExpressionValueType_Decimal: 4,
    ExpressionValueType_Boolean: 5,
    0: "ExpressionValueType_Unknown",
    1: "ExpressionValueType_String",
    2: "ExpressionValueType_Number",
    3: "ExpressionValueType_Integer",
    4: "ExpressionValueType_Decimal",
    5: "ExpressionValueType_Boolean",
  },
  InteractionPart: {
    InteractionPart_Request: 0,
    InteractionPart_Response: 1,
    0: "InteractionPart_Request",
    1: "InteractionPart_Response",
  },
  LevelFilter: {
    LevelFilter_Off: 0,
    LevelFilter_Error: 1,
    LevelFilter_Warn: 2,
    LevelFilter_Info: 3,
    LevelFilter_Debug: 4,
    LevelFilter_Trace: 5,
    0: "LevelFilter_Off",
    1: "LevelFilter_Error",
    2: "LevelFilter_Warn",
    3: "LevelFilter_Info",
    4: "LevelFilter_Debug",
    5: "LevelFilter_Trace",
  },
  MatchingRuleResult_Tag: {
    MatchingRuleResult_MatchingRule: 0,
    MatchingRuleResult_MatchingReference: 1,
    0: "MatchingRuleResult_MatchingRule",
    1: "MatchingRuleResult_MatchingReference",
  },
  PactSpecification: {
    PactSpecification_Unknown: 0,
    PactSpecification_V1: 1,
    PactSpecification_V1_1: 2,
    PactSpecification_V2: 3,
    PactSpecification_V3: 4,
    PactSpecification_V4: 5,
    0: "PactSpecification_Unknown",
    1: "PactSpecification_V1",
    2: "PactSpecification_V1_1",
    3: "PactSpecification_V2",
    4: "PactSpecification_V3",
    5: "PactSpecification_V4",
  },
  StringResult_Tag: {
    StringResult_Ok: 0,
    StringResult_Failed: 1,
    0: "StringResult_Ok",
    1: "StringResult_Failed",
  },
};

// NOTE: defining individual types as "global" constants to be able to reference them without any prefix.
const types = {};

const js_uchar = ref.types.uchar;
const js_CString = ref.types.CString;
const js_void = ref.types.void;
const js_voidPointer = ref.refType(js_void);
const Mismatches = js_voidPointer;
const Message = js_voidPointer;
const MismatchesIterator = js_voidPointer;
const Mismatch = js_voidPointer;
const js_int32 = ref.types.int32;
const js_uint32 = ref.types.uint32;
const Pact = js_voidPointer;
const Consumer = js_voidPointer;
const js_ucharPointer = ref.refType(js_uchar);
const ProviderState = js_voidPointer;
const ProviderStateIterator = js_voidPointer;
const MessageMetadataIterator = js_voidPointer;
const MessageMetadataPair = Struct({
  key: js_CString,
  value: js_CString,
});
const MessagePact = js_voidPointer;
const Provider = js_voidPointer;
const MessagePactMessageIterator = js_voidPointer;
const MessagePactMetadataIterator = js_voidPointer;
const MessagePactMetadataTriple = Struct({
  outer_key: js_CString,
  inner_key: js_CString,
  value: js_CString,
});
const ProviderStateParamIterator = js_voidPointer;
const ProviderStateParamPair = Struct({
  key: js_CString,
  value: js_CString,
});
const PactMessageIterator = js_voidPointer;
const SynchronousMessage = js_voidPointer;
const PactSyncMessageIterator = js_voidPointer;
const SynchronousHttp = js_voidPointer;
const PactSyncHttpIterator = js_voidPointer;
const MatchingRuleDefinitionResult = js_voidPointer;
const Generator = js_voidPointer;
const MatchingRuleIterator = js_voidPointer;
const MatchingRuleResult_Tag = js_uint32;
const js_ushort = ref.types.ushort;
const uint16_t = js_ushort;
const MatchingRule = js_voidPointer;
const MatchingRuleResult_MatchingRule_Body = Struct({
  _0: uint16_t,
  _1: js_CString,
  _2: MatchingRule,
});
const MatchingRuleResult___Ua___Sa_1 = Struct({
  matching_reference: js_CString,
});
const MatchingRuleResult___Ua_0 = Union({
  matching_rule: MatchingRuleResult_MatchingRule_Body,
  anonymous_0: MatchingRuleResult___Ua___Sa_1,
});
const MatchingRuleResult = Struct({
  tag: MatchingRuleResult_Tag,
  anonymous_0: MatchingRuleResult___Ua_0,
});
const int32_t = js_int32;
const js_byte = ref.types.byte;
const PactHandle = uint16_t;
const StringResult_Tag = js_uint32;
const StringResult___Ua___Sa_3 = Struct({
  ok: js_CString,
});
const StringResult___Ua___Sa_4 = Struct({
  failed: js_CString,
});
const StringResult___Ua_2 = Union({
  anonymous_0: StringResult___Ua___Sa_3,
  anonymous_1: StringResult___Ua___Sa_4,
});
const StringResult = Struct({
  tag: StringResult_Tag,
  anonymous_0: StringResult___Ua_2,
});
const uint32_t = js_uint32;
const InteractionHandle = uint32_t;
const uint8_t = js_uchar;
const uint8_tPointer = ref.refType(uint8_t);
const MessagePactHandle = uint16_t;
const MessageHandle = uint32_t;
const VerifierHandle = js_voidPointer;
const js_ulong = ref.types.ulong;

types["Consumer"] = Consumer;
types["Generator"] = Generator;
types["InteractionHandle"] = InteractionHandle;
types["MatchingRule"] = MatchingRule;
types["MatchingRuleDefinitionResult"] = MatchingRuleDefinitionResult;
types["MatchingRuleIterator"] = MatchingRuleIterator;
types["MatchingRuleResult"] = MatchingRuleResult;
types["MatchingRuleResult_MatchingRule_Body"] =
  MatchingRuleResult_MatchingRule_Body;
types["MatchingRuleResult_Tag"] = MatchingRuleResult_Tag;
types["MatchingRuleResult___Ua_0"] = MatchingRuleResult___Ua_0;
types["MatchingRuleResult___Ua___Sa_1"] = MatchingRuleResult___Ua___Sa_1;
types["Message"] = Message;
types["MessageHandle"] = MessageHandle;
types["MessageMetadataIterator"] = MessageMetadataIterator;
types["MessageMetadataPair"] = MessageMetadataPair;
types["MessagePact"] = MessagePact;
types["MessagePactHandle"] = MessagePactHandle;
types["MessagePactMessageIterator"] = MessagePactMessageIterator;
types["MessagePactMetadataIterator"] = MessagePactMetadataIterator;
types["MessagePactMetadataTriple"] = MessagePactMetadataTriple;
types["Mismatch"] = Mismatch;
types["Mismatches"] = Mismatches;
types["MismatchesIterator"] = MismatchesIterator;
types["Pact"] = Pact;
types["PactHandle"] = PactHandle;
types["PactMessageIterator"] = PactMessageIterator;
types["PactSyncHttpIterator"] = PactSyncHttpIterator;
types["PactSyncMessageIterator"] = PactSyncMessageIterator;
types["Provider"] = Provider;
types["ProviderState"] = ProviderState;
types["ProviderStateIterator"] = ProviderStateIterator;
types["ProviderStateParamIterator"] = ProviderStateParamIterator;
types["ProviderStateParamPair"] = ProviderStateParamPair;
types["StringResult"] = StringResult;
types["StringResult_Tag"] = StringResult_Tag;
types["StringResult___Ua_2"] = StringResult___Ua_2;
types["StringResult___Ua___Sa_3"] = StringResult___Ua___Sa_3;
types["StringResult___Ua___Sa_4"] = StringResult___Ua___Sa_4;
types["SynchronousHttp"] = SynchronousHttp;
types["SynchronousMessage"] = SynchronousMessage;
types["VerifierHandle"] = VerifierHandle;
types["int32_t"] = int32_t;
types["js_CString"] = js_CString;
types["js_byte"] = js_byte;
types["js_int32"] = js_int32;
types["js_uchar"] = js_uchar;
types["js_ucharPointer"] = js_ucharPointer;
types["js_uint32"] = js_uint32;
types["js_ulong"] = js_ulong;
types["js_ushort"] = js_ushort;
types["js_void"] = js_void;
types["js_voidPointer"] = js_voidPointer;
types["uint16_t"] = uint16_t;
types["uint32_t"] = uint32_t;
types["uint8_t"] = uint8_t;
types["uint8_tPointer"] = uint8_tPointer;

const functions = new FFI.Library("libpact_ffi", {
  pactffi_check_regex: [js_byte, [js_CString, js_CString]],
  pactffi_cleanup_mock_server: [js_byte, [int32_t]],
  pactffi_cleanup_plugins: [js_void, [PactHandle]],
  pactffi_consumer_get_name: [js_CString, [Consumer]],
  pactffi_create_mock_server: [int32_t, [js_CString, js_CString, js_byte]],
  pactffi_create_mock_server_for_pact: [
    int32_t,
    [PactHandle, js_CString, js_byte],
  ],
  pactffi_create_mock_server_for_transport: [
    int32_t,
    [PactHandle, js_CString, uint16_t, js_CString, js_CString],
  ],
  pactffi_enable_ansi_support: [js_void, []],
  pactffi_fetch_log_buffer: [js_CString, [js_CString]],
  pactffi_free_message_pact_handle: [js_uint32, [MessagePactHandle]],
  pactffi_free_pact_handle: [js_uint32, [PactHandle]],
  pactffi_free_string: [js_void, [js_CString]],
  pactffi_generate_datetime_string: [StringResult, [js_CString]],
  pactffi_generate_regex_value: [StringResult, [js_CString]],
  pactffi_generator_generate_integer: [js_ushort, [Generator, js_CString]],
  pactffi_generator_generate_string: [js_CString, [Generator, js_CString]],
  pactffi_generator_to_json: [js_CString, [Generator]],
  pactffi_get_error_message: [js_int32, [js_CString, js_int32]],
  pactffi_get_tls_ca_certificate: [js_CString, []],
  pactffi_given: [js_byte, [InteractionHandle, js_CString]],
  pactffi_given_with_param: [
    js_byte,
    [InteractionHandle, js_CString, js_CString, js_CString],
  ],
  pactffi_init: [js_void, [js_CString]],
  pactffi_init_with_log_level: [js_void, [js_CString]],
  pactffi_interaction_contents: [
    js_uint32,
    [InteractionHandle, js_uint32, js_CString, js_CString],
  ],
  pactffi_interaction_test_name: [js_uint32, [InteractionHandle, js_CString]],
  pactffi_log_message: [js_void, [js_CString, js_CString, js_CString]],
  pactffi_log_to_buffer: [js_int32, [js_uint32]],
  pactffi_log_to_file: [js_int32, [js_CString, js_uint32]],
  pactffi_log_to_stderr: [js_int32, [js_uint32]],
  pactffi_log_to_stdout: [js_int32, [js_uint32]],
  pactffi_logger_apply: [js_int32, []],
  pactffi_logger_attach_sink: [js_int32, [js_CString, js_uint32]],
  pactffi_logger_init: [js_void, []],
  pactffi_match_message: [Mismatches, [Message, Message]],
  pactffi_matcher_definition_delete: [js_void, [MatchingRuleDefinitionResult]],
  pactffi_matcher_definition_error: [
    js_CString,
    [MatchingRuleDefinitionResult],
  ],
  pactffi_matcher_definition_generator: [
    Generator,
    [MatchingRuleDefinitionResult],
  ],
  pactffi_matcher_definition_iter: [
    MatchingRuleIterator,
    [MatchingRuleDefinitionResult],
  ],
  pactffi_matcher_definition_value: [
    js_CString,
    [MatchingRuleDefinitionResult],
  ],
  pactffi_matcher_definition_value_type: [
    js_uint32,
    [MatchingRuleDefinitionResult],
  ],
  pactffi_matching_rule_iter_delete: [js_void, [MatchingRuleIterator]],
  pactffi_matching_rule_iter_next: [MatchingRuleResult, [MatchingRuleIterator]],
  pactffi_matching_rule_to_json: [js_CString, [MatchingRule]],
  pactffi_message_delete: [js_void, [Message]],
  pactffi_message_expects_to_receive: [js_void, [MessageHandle, js_CString]],
  pactffi_message_find_metadata: [js_CString, [Message, js_CString]],
  pactffi_message_get_contents: [js_CString, [Message]],
  pactffi_message_get_contents_bin: [js_ucharPointer, [Message]],
  pactffi_message_get_contents_length: [js_int32, [Message]],
  pactffi_message_get_description: [js_CString, [Message]],
  pactffi_message_get_metadata_iter: [MessageMetadataIterator, [Message]],
  pactffi_message_get_provider_state: [ProviderState, [Message, js_uint32]],
  pactffi_message_get_provider_state_iter: [ProviderStateIterator, [Message]],
  pactffi_message_given: [js_void, [MessageHandle, js_CString]],
  pactffi_message_given_with_param: [
    js_void,
    [MessageHandle, js_CString, js_CString, js_CString],
  ],
  pactffi_message_insert_metadata: [
    js_int32,
    [Message, js_CString, js_CString],
  ],
  pactffi_message_metadata_iter_delete: [js_void, [MessageMetadataIterator]],
  pactffi_message_metadata_iter_next: [
    MessageMetadataPair,
    [MessageMetadataIterator],
  ],
  pactffi_message_metadata_pair_delete: [js_void, [MessageMetadataPair]],
  pactffi_message_new: [Message, []],
  pactffi_message_new_from_body: [Message, [js_CString, js_CString]],
  pactffi_message_new_from_json: [Message, [js_uint32, js_CString, js_uint32]],
  pactffi_message_pact_delete: [js_void, [MessagePact]],
  pactffi_message_pact_find_metadata: [
    js_CString,
    [MessagePact, js_CString, js_CString],
  ],
  pactffi_message_pact_get_consumer: [Consumer, [MessagePact]],
  pactffi_message_pact_get_message_iter: [
    MessagePactMessageIterator,
    [MessagePact],
  ],
  pactffi_message_pact_get_metadata_iter: [
    MessagePactMetadataIterator,
    [MessagePact],
  ],
  pactffi_message_pact_get_provider: [Provider, [MessagePact]],
  pactffi_message_pact_message_iter_delete: [
    js_void,
    [MessagePactMessageIterator],
  ],
  pactffi_message_pact_message_iter_next: [
    Message,
    [MessagePactMessageIterator],
  ],
  pactffi_message_pact_metadata_iter_delete: [
    js_void,
    [MessagePactMetadataIterator],
  ],
  pactffi_message_pact_metadata_iter_next: [
    MessagePactMetadataTriple,
    [MessagePactMetadataIterator],
  ],
  pactffi_message_pact_metadata_triple_delete: [
    js_void,
    [MessagePactMetadataTriple],
  ],
  pactffi_message_pact_new_from_json: [MessagePact, [js_CString, js_CString]],
  pactffi_message_reify: [js_CString, [MessageHandle]],
  pactffi_message_set_contents: [js_void, [Message, js_CString, js_CString]],
  pactffi_message_set_contents_bin: [
    js_void,
    [Message, js_ucharPointer, js_int32, js_CString],
  ],
  pactffi_message_set_description: [js_int32, [Message, js_CString]],
  pactffi_message_with_contents: [
    js_void,
    [MessageHandle, js_CString, uint8_tPointer, js_int32],
  ],
  pactffi_message_with_metadata: [
    js_void,
    [MessageHandle, js_CString, js_CString],
  ],
  pactffi_mismatch_ansi_description: [js_CString, [Mismatch]],
  pactffi_mismatch_description: [js_CString, [Mismatch]],
  pactffi_mismatch_summary: [js_CString, [Mismatch]],
  pactffi_mismatch_to_json: [js_CString, [Mismatch]],
  pactffi_mismatch_type: [js_CString, [Mismatch]],
  pactffi_mismatches_delete: [js_void, [Mismatches]],
  pactffi_mismatches_get_iter: [MismatchesIterator, [Mismatches]],
  pactffi_mismatches_iter_delete: [js_void, [MismatchesIterator]],
  pactffi_mismatches_iter_next: [Mismatch, [MismatchesIterator]],
  pactffi_mock_server_logs: [js_CString, [int32_t]],
  pactffi_mock_server_matched: [js_byte, [int32_t]],
  pactffi_mock_server_mismatches: [js_CString, [int32_t]],
  pactffi_new_async_message: [MessageHandle, [PactHandle, js_CString]],
  pactffi_new_interaction: [InteractionHandle, [PactHandle, js_CString]],
  pactffi_new_message: [MessageHandle, [MessagePactHandle, js_CString]],
  pactffi_new_message_interaction: [
    InteractionHandle,
    [PactHandle, js_CString],
  ],
  pactffi_new_message_pact: [MessagePactHandle, [js_CString, js_CString]],
  pactffi_new_pact: [PactHandle, [js_CString, js_CString]],
  pactffi_new_sync_message_interaction: [
    InteractionHandle,
    [PactHandle, js_CString],
  ],
  pactffi_pact_handle_get_message_iter: [PactMessageIterator, [PactHandle]],
  pactffi_pact_handle_get_sync_http_iter: [PactSyncHttpIterator, [PactHandle]],
  pactffi_pact_handle_get_sync_message_iter: [
    PactSyncMessageIterator,
    [PactHandle],
  ],
  pactffi_pact_handle_write_file: [int32_t, [PactHandle, js_CString, js_byte]],
  pactffi_pact_message_iter_delete: [js_void, [PactMessageIterator]],
  pactffi_pact_message_iter_next: [Message, [PactMessageIterator]],
  pactffi_pact_model_delete: [js_void, [Pact]],
  pactffi_pact_sync_http_iter_delete: [js_void, [PactSyncHttpIterator]],
  pactffi_pact_sync_http_iter_next: [SynchronousHttp, [PactSyncHttpIterator]],
  pactffi_pact_sync_message_iter_delete: [js_void, [PactSyncMessageIterator]],
  pactffi_pact_sync_message_iter_next: [
    SynchronousMessage,
    [PactSyncMessageIterator],
  ],
  pactffi_parse_matcher_definition: [
    MatchingRuleDefinitionResult,
    [js_CString],
  ],
  pactffi_parse_pact_json: [Pact, [js_CString]],
  pactffi_provider_get_name: [js_CString, [Provider]],
  pactffi_provider_state_delete: [js_void, [ProviderState]],
  pactffi_provider_state_get_name: [js_CString, [ProviderState]],
  pactffi_provider_state_get_param_iter: [
    ProviderStateParamIterator,
    [ProviderState],
  ],
  pactffi_provider_state_iter_delete: [js_void, [ProviderStateIterator]],
  pactffi_provider_state_iter_next: [ProviderState, [ProviderStateIterator]],
  pactffi_provider_state_param_iter_delete: [
    js_void,
    [ProviderStateParamIterator],
  ],
  pactffi_provider_state_param_iter_next: [
    ProviderStateParamPair,
    [ProviderStateParamIterator],
  ],
  pactffi_provider_state_param_pair_delete: [js_void, [ProviderStateParamPair]],
  pactffi_response_status: [js_byte, [InteractionHandle, js_ushort]],
  pactffi_string_delete: [js_void, [js_CString]],
  pactffi_sync_http_delete: [js_void, [SynchronousHttp]],
  pactffi_sync_http_get_description: [js_CString, [SynchronousHttp]],
  pactffi_sync_http_get_provider_state: [
    ProviderState,
    [SynchronousHttp, js_uint32],
  ],
  pactffi_sync_http_get_provider_state_iter: [
    ProviderStateIterator,
    [SynchronousHttp],
  ],
  pactffi_sync_http_get_request_contents: [js_CString, [SynchronousHttp]],
  pactffi_sync_http_get_request_contents_bin: [
    js_ucharPointer,
    [SynchronousHttp],
  ],
  pactffi_sync_http_get_request_contents_length: [js_int32, [SynchronousHttp]],
  pactffi_sync_http_get_response_contents: [js_CString, [SynchronousHttp]],
  pactffi_sync_http_get_response_contents_bin: [
    js_ucharPointer,
    [SynchronousHttp],
  ],
  pactffi_sync_http_get_response_contents_length: [js_int32, [SynchronousHttp]],
  pactffi_sync_http_new: [SynchronousHttp, []],
  pactffi_sync_http_set_description: [js_int32, [SynchronousHttp, js_CString]],
  pactffi_sync_http_set_request_contents: [
    js_void,
    [SynchronousHttp, js_CString, js_CString],
  ],
  pactffi_sync_http_set_request_contents_bin: [
    js_void,
    [SynchronousHttp, js_ucharPointer, js_int32, js_CString],
  ],
  pactffi_sync_http_set_response_contents: [
    js_void,
    [SynchronousHttp, js_CString, js_CString],
  ],
  pactffi_sync_http_set_response_contents_bin: [
    js_void,
    [SynchronousHttp, js_ucharPointer, js_int32, js_CString],
  ],
  pactffi_sync_message_delete: [js_void, [SynchronousMessage]],
  pactffi_sync_message_get_description: [js_CString, [SynchronousMessage]],
  pactffi_sync_message_get_number_responses: [js_int32, [SynchronousMessage]],
  pactffi_sync_message_get_provider_state: [
    ProviderState,
    [SynchronousMessage, js_uint32],
  ],
  pactffi_sync_message_get_provider_state_iter: [
    ProviderStateIterator,
    [SynchronousMessage],
  ],
  pactffi_sync_message_get_request_contents: [js_CString, [SynchronousMessage]],
  pactffi_sync_message_get_request_contents_bin: [
    js_ucharPointer,
    [SynchronousMessage],
  ],
  pactffi_sync_message_get_request_contents_length: [
    js_int32,
    [SynchronousMessage],
  ],
  pactffi_sync_message_get_response_contents: [
    js_CString,
    [SynchronousMessage, js_int32],
  ],
  pactffi_sync_message_get_response_contents_bin: [
    js_ucharPointer,
    [SynchronousMessage, js_int32],
  ],
  pactffi_sync_message_get_response_contents_length: [
    js_int32,
    [SynchronousMessage, js_int32],
  ],
  pactffi_sync_message_new: [SynchronousMessage, []],
  pactffi_sync_message_set_description: [
    js_int32,
    [SynchronousMessage, js_CString],
  ],
  pactffi_sync_message_set_request_contents: [
    js_void,
    [SynchronousMessage, js_CString, js_CString],
  ],
  pactffi_sync_message_set_request_contents_bin: [
    js_void,
    [SynchronousMessage, js_ucharPointer, js_int32, js_CString],
  ],
  pactffi_sync_message_set_response_contents: [
    js_void,
    [SynchronousMessage, js_int32, js_CString, js_CString],
  ],
  pactffi_sync_message_set_response_contents_bin: [
    js_void,
    [SynchronousMessage, js_int32, js_ucharPointer, js_int32, js_CString],
  ],
  pactffi_upon_receiving: [js_byte, [InteractionHandle, js_CString]],
  pactffi_using_plugin: [js_uint32, [PactHandle, js_CString, js_CString]],
  pactffi_verifier_add_custom_header: [
    js_void,
    [VerifierHandle, js_CString, js_CString],
  ],
  pactffi_verifier_add_directory_source: [
    js_void,
    [VerifierHandle, js_CString],
  ],
  pactffi_verifier_add_file_source: [js_void, [VerifierHandle, js_CString]],
  pactffi_verifier_add_provider_transport: [
    js_void,
    [VerifierHandle, js_CString, js_ushort, js_CString, js_CString],
  ],
  pactffi_verifier_broker_source: [
    js_void,
    [VerifierHandle, js_CString, js_CString, js_CString, js_CString],
  ],
  pactffi_verifier_broker_source_with_selectors: [
    js_void,
    [
      VerifierHandle,
      js_CString,
      js_CString,
      js_CString,
      js_CString,
      js_uchar,
      js_CString,
      js_CString,
      js_ushort,
      js_CString,
      js_CString,
      js_ushort,
      js_CString,
      js_ushort,
    ],
  ],
  pactffi_verifier_cli_args: [js_CString, []],
  pactffi_verifier_execute: [js_int32, [VerifierHandle]],
  pactffi_verifier_json: [js_CString, [VerifierHandle]],
  pactffi_verifier_logs: [js_CString, [VerifierHandle]],
  pactffi_verifier_logs_for_provider: [js_CString, [js_CString]],
  pactffi_verifier_new: [VerifierHandle, []],
  pactffi_verifier_new_for_application: [
    VerifierHandle,
    [js_CString, js_CString],
  ],
  pactffi_verifier_output: [js_CString, [VerifierHandle, js_uchar]],
  pactffi_verifier_set_coloured_output: [js_int32, [VerifierHandle, js_uchar]],
  pactffi_verifier_set_consumer_filters: [
    js_void,
    [VerifierHandle, js_CString, js_ushort],
  ],
  pactffi_verifier_set_filter_info: [
    js_void,
    [VerifierHandle, js_CString, js_CString, js_uchar],
  ],
  pactffi_verifier_set_no_pacts_is_error: [
    js_int32,
    [VerifierHandle, js_uchar],
  ],
  pactffi_verifier_set_provider_info: [
    js_void,
    [VerifierHandle, js_CString, js_CString, js_CString, js_ushort, js_CString],
  ],
  pactffi_verifier_set_provider_state: [
    js_void,
    [VerifierHandle, js_CString, js_uchar, js_uchar],
  ],
  pactffi_verifier_set_publish_options: [
    js_int32,
    [VerifierHandle, js_CString, js_CString, js_CString, js_ushort, js_CString],
  ],
  pactffi_verifier_set_verification_options: [
    js_int32,
    [VerifierHandle, js_uchar, js_ulong],
  ],
  pactffi_verifier_shutdown: [js_void, [VerifierHandle]],
  pactffi_verifier_url_source: [
    js_void,
    [VerifierHandle, js_CString, js_CString, js_CString, js_CString],
  ],
  pactffi_verify: [int32_t, [js_CString]],
  pactffi_version: [js_CString, []],
  pactffi_with_binary_file: [
    js_byte,
    [InteractionHandle, js_uint32, js_CString, uint8_tPointer, js_int32],
  ],
  pactffi_with_body: [
    js_byte,
    [InteractionHandle, js_uint32, js_CString, js_CString],
  ],
  pactffi_with_header: [
    js_byte,
    [InteractionHandle, js_uint32, js_CString, js_int32, js_CString],
  ],
  pactffi_with_header_v2: [
    js_byte,
    [InteractionHandle, js_uint32, js_CString, js_int32, js_CString],
  ],
  pactffi_with_message_pact_metadata: [
    js_void,
    [MessagePactHandle, js_CString, js_CString, js_CString],
  ],
  pactffi_with_multipart_file: [
    StringResult,
    [InteractionHandle, js_uint32, js_CString, js_CString, js_CString],
  ],
  pactffi_with_pact_metadata: [
    js_byte,
    [PactHandle, js_CString, js_CString, js_CString],
  ],
  pactffi_with_query_parameter: [
    js_byte,
    [InteractionHandle, js_CString, js_int32, js_CString],
  ],
  pactffi_with_query_parameter_v2: [
    js_byte,
    [InteractionHandle, js_CString, js_int32, js_CString],
  ],
  pactffi_with_request: [js_byte, [InteractionHandle, js_CString, js_CString]],
  pactffi_with_specification: [js_byte, [PactHandle, js_uint32]],
  pactffi_write_message_pact_file: [
    int32_t,
    [MessagePactHandle, js_CString, js_byte],
  ],
  pactffi_write_pact_file: [int32_t, [int32_t, js_CString, js_byte]],
});

module.exports = {
  constants,
  types,
  functions,
};

