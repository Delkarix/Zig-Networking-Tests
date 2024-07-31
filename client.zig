const std = @import("std");

pub fn main() !void {
    std.debug.print("Creating allocator...\n", .{});
    var allocator = std.heap.GeneralPurposeAllocator(.{ .never_unmap = true, .retain_metadata = true, .verbose_log = true }){};
    defer _ = allocator.deinit();

    std.debug.print("Connecting to server...\n", .{});
    var stream = try std.net.tcpConnectToHost(allocator.allocator(), "127.0.0.1", 4446);
    std.debug.print("Connected to server.\n", .{});

    std.debug.print("Sending message to server...\n", .{});
    _ = try stream.write("hello friend!");
    defer stream.close();
    std.debug.print("Sent message.\n", .{});
}
