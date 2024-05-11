# https://makefiletutorial.com/#multiple-targets
include ./dsl/*.mk
include ./sql/*.mk
# include ./gt/Makefile
include ./fp/*.mk

all: go.all lua.all node.all py.all rust.all zig.all
