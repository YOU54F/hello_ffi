const c = @cImport({
    @cInclude("pact.h");
});
const cURL = @cImport({
    @cInclude("curl/curl.h");
});

const std = @import("std");
const Request = @import("http").Request;
pub extern fn pactffi_version() [*c]u8;

// Loggers
pub extern fn pactffi_logger_init() void;
pub extern fn pactffi_logger_attach_sink([*c]const u8, i32) i32;
pub extern fn pactffi_logger_apply() i32;
pub extern fn pactffi_log_message([*c]const u8, [*c]const u8, [*c]const u8) void;

// Mock server
pub extern fn pactffi_create_mock_server([*c]const u8, [*c]const u8, i32) i32;
pub extern fn pactffi_cleanup_mock_server(i32) i32;
pub extern fn pactffi_mock_server_matched(i32) bool;
pub extern fn pactffi_write_pact_file(i32, [*c]const u8, bool) i32;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const version: [*c]u8 = pactffi_version();
    try stdout.print("{s}\n", .{version});
    pactffi_logger_init();
    const pactffi_logger_attach_sink_res: i32 = pactffi_logger_attach_sink("stdout", 3);
    try stdout.print("pactffi_logger_attach_sink result {}\n", .{pactffi_logger_attach_sink_res});
    const pactffi_logger_apply_res: i32 = pactffi_logger_apply();
    pactffi_log_message("pact-zig-ffi", "INFO", "Pact Zig FFI is alive");
    try stdout.print("pactffi_logger_apply_res {}\n", .{pactffi_logger_apply_res});

    const pact =
        \\ {"consumer":{"name":"pact-raku-ffi"},"interactions":[{"description":"a retrieve Mallory request","request":{"method":"GET","path":"/mallory","query":"name=ron&status=good"},"response":{"body":"That is some good Mallory.","headers":{"Content-Type":"text/html"},"status":200}}],"metadata":{"pact-zig":{"ffi":"0.3.15","version":"1.0.0"},"pactRust":{"mockserver":"0.9.5","models":"1.0.0"},"pactSpecification":{"version":"1.0.0"}},"provider":{"name":"Alice Service"}}
    ;
    const mock_server_port: i32 = pactffi_create_mock_server(pact, "127.0.0.1:4432", 0);
    pactffi_log_message("pact-zig-ffi", "INFO", "mock_server_port: $mock_server_port");
    try stdout.print("mock_server_port result {}\n", .{mock_server_port});
    const result = make_request("http://127.0.0.1:4432/mallory?name=ron&status=good");
    try stdout.print("matched result {!}\n", .{result});

    const matched: bool = pactffi_mock_server_matched(mock_server_port);
    pactffi_log_message("pact-zig-ffi", "INFO", "pactffi_mock_server_matched: $matched");
    try stdout.print("matched result {}\n", .{matched});

    if (matched) {
        const PACT_FILE_DIR = "./pacts";
        const res_write_pact: i32 = pactffi_write_pact_file(mock_server_port, PACT_FILE_DIR, false);
        pactffi_log_message("pact-zig-ffi", "INFO", "pactffi_write_pact_file: $res_write_pact");
        try stdout.print("res_write_pact result {}\n", .{res_write_pact});
    }

    const pactffi_cleanup_mock_server_result: i32 = pactffi_cleanup_mock_server(mock_server_port);
    pactffi_log_message("pact-zig-ffi", "INFO", "pactffi_cleanup_mock_server");
    try stdout.print("pactffi_cleanup_mock_server_result result {}\n", .{pactffi_cleanup_mock_server_result});
}

pub fn make_request(url: [*c]const u8) !void {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.c_allocator);
    defer arena_state.deinit();

    const allocator = arena_state.allocator();

    // global curl init, or fail
    if (cURL.curl_global_init(cURL.CURL_GLOBAL_ALL) != cURL.CURLE_OK)
        return error.CURLGlobalInitFailed;
    defer cURL.curl_global_cleanup();

    // curl easy handle init, or fail
    const handle = cURL.curl_easy_init() orelse return error.CURLHandleInitFailed;
    defer cURL.curl_easy_cleanup(handle);

    var response_buffer = std.ArrayList(u8).init(allocator);

    // superfluous when using an arena allocator, but
    // important if the allocator implementation changes
    defer response_buffer.deinit();

    // setup curl options
    if (cURL.curl_easy_setopt(handle, cURL.CURLOPT_URL, url) != cURL.CURLE_OK)
        return error.CouldNotSetURL;

    // set write function callbacks
    if (cURL.curl_easy_setopt(handle, cURL.CURLOPT_WRITEFUNCTION, writeToArrayListCallback) != cURL.CURLE_OK)
        return error.CouldNotSetWriteCallback;
    if (cURL.curl_easy_setopt(handle, cURL.CURLOPT_WRITEDATA, &response_buffer) != cURL.CURLE_OK)
        return error.CouldNotSetWriteCallback;

    // perform
    if (cURL.curl_easy_perform(handle) != cURL.CURLE_OK)
        return error.FailedToPerformRequest;

    std.log.info("Got response of {d} bytes", .{response_buffer.items.len});
    std.debug.print("{s}\n", .{response_buffer.items});
    // return response_buffer.items;
}

fn writeToArrayListCallback(data: *anyopaque, size: c_uint, nmemb: c_uint, user_data: *anyopaque) callconv(.C) c_uint {
    // note casted built-ins changed in 0.11.0 https://ziglang.org/download/0.11.0/release-notes.html#Rename-Casting-Builtins
    var buffer = @as(*std.ArrayList(u8), @ptrFromInt(@intFromPtr(user_data)));
    var typed_data = @as([*]u8, @ptrFromInt(@intFromPtr(data)));
    buffer.appendSlice(typed_data[0 .. nmemb * size]) catch return 0;
    return nmemb * size;
}
