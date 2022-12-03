



const c = @cImport({
    @cInclude("pact.h");
});
const std = @import("std");
pub extern fn pactffi_version() [*c]u8;
pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    var version: [*c]u8 = pactffi_version();
    try stdout.print("{s}\n", .{version});
}