const std = @import("std");
const wav = @import("wav.zig");
const gen = @import("gen.zig");
const file = @import("file.zig");

// Banner text.
const text = "【ｌｉｎｕｘｗａｖｅ】";
// File to read.
const source_file = "/dev/urandom";
// Semitones from the base note in a major musical scale.
const scale = [_]f32{ 0, 2, 3, 5, 7, 8, 10, 12 };
// Frequency of A4. (<https://en.wikipedia.org/wiki/A440_(pitch_standard)>)
const frequency: f32 = 440;
// Volume control.
const volume: u8 = 50;

pub fn main() !void {
    // Print banner text.
    std.debug.print("{s}\n", .{text});

    // Read data from a file.
    var buf: [64]u8 = undefined;
    const buffer = try file.readBytes(source_file, &buf);
    std.debug.print("{d}\n", .{buffer});

    // Generate music.
    const generator = gen.Generator(&scale, frequency, volume);
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var data = std.ArrayList(u8).init(allocator);
    for (buffer) |v| {
        var gen_data = try generator.generate(allocator, v);
        defer allocator.free(gen_data);
        try data.appendSlice(gen_data);
    }

    // Encode WAV.
    const stdout = std.io.getStdOut().writer();
    try wav.Encoder(@TypeOf(stdout)).encode(stdout, data.toOwnedSlice(), .{
        .num_channels = 1,
        .sample_rate = 24000,
        .format = .signed16_lsb,
    });
}
