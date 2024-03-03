# zig-cache zig-out

zig.all: zig.run zig.test

zig.init:
	zig init
zig.run:
	zig run ./src/main.zig
zig.test:
	zig test ./src/main.zig
zig.clean:
	rm -rf ./zig-cache

