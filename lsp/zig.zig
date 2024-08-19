const std = @import("std");

///**main function**.
pub fn main() void {
    std.debug.print("Hello, {s}!\n", .{"Zig"});
}

/// Increment function
pub fn inc(n: i8) i8 {
    return n + 1;
}

test "simple test" {
    try std.testing.expectEqual(inc(1), 2);
}
