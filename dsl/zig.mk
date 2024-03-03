# https://ziglang.org/
# https://zig.guide/
# zig-cache zig-out 

zig.init:
	zig init-exe
zig.clean:
	rm -rf ./zig-cache ./build.zig ./src/main.zig main main.o
zig.run:
	zig run ./dsl/zig.zig
zig.test:
	zig test ./dsl/zig.zig

