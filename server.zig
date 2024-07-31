const std = @import("std");

pub fn main() !void {
    std.debug.print("Resolving IP...\n", .{});
    const addr = try std.net.Address.resolveIp("127.0.0.1", 4446);

    std.debug.print("Starting Server...\n", .{});
    var serv = try addr.listen(.{});
    defer serv.deinit();

    const connection = try serv.accept();
    std.debug.print("Connection made at {}\n", .{connection.address.getPort()});

    var buff: [2048]u8 = undefined;
    const bytes_read = try connection.stream.readAll(&buff);
    std.debug.print("Message: {s}\n", .{buff[0..bytes_read]});
}
