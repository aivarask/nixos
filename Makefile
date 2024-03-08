# https://makefiletutorial.com/#multiple-targets
include ./dsl/*.mk
include ./sql/*.mk
include ./src/Makefile

all: go.all lua.all node.all py.all rust.all zig.all
