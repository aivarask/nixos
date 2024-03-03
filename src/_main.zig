const std = @import("std");

/// This is main function
pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, {s}!\n", .{"zig"});
}

test "simple test" {
    try std.testing.expectEqual(1, 1);
}
