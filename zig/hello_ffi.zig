const c = @cImport({
    @cInclude("pact.h");
});
pub extern fn pactffi_version() [*c]u8;
pub extern fn pactffi_logger_init() void;
pub extern fn pactffi_logger_attach_sink([*c]const u8, i32) i32;
pub extern fn pactffi_logger_apply() i32;
pub extern fn pactffi_log_message([*c]const u8,[*c]const u8,[*c]const u8) void;

pub fn main() !void {
    var version: [*c]u8 = pactffi_version();
    pactffi_logger_init();
    _ = pactffi_logger_attach_sink("stdout",3);
    _ = pactffi_logger_apply();
    // var versionLength = std.mem.span(version).len; // this returns 6
    // var message = "hello from ffi version: "++version[0..versionLength]; // this results in a comp time error
    pactffi_log_message("pact-zig-ffi","INFO","hello from ffi version: "++version[0..6]);
}