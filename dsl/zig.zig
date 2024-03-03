const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"Zig"});
}

test "simple test" {
    try std.testing.expectEqual(1, 1);
}
