# https://ziglang.org/
# https://zig.guide/
# zig-cache zig-out 

zig.clean:
	rm -rf ./docs/zig ./zig-cache ./build.zig ./src/main.zig main main.o
zig.test:
	zig test ./dsl/zig.zig
zig.run:
	zig run ./dsl/zig.zig
zig.doc:
	mkdir ./docs/zig; zig run ./dsl/zig.zig -femit-docs='./docs/zig'
zig.all: zig.test zig.run zig.doc
