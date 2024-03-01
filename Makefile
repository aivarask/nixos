# C
cc:
	cc -fsyntax-only ./src/main.c
gcc:
	gcc -fsyntax-only ./src/main.c
ccompile: 
	clang --analyze ./src/main.c
crun:
	clang -o ./src/mainc ./src/main.c; ./src/mainc

go.all: go.run go.test
go.run:
	go run ./src/main.go
go.test:
	go test
go.debug:
	dlv debug

lua.all: lua.run lua.test lua.doc
lua.run:
	lua ./lua/init.lua
lua.test:
	busted
lua.doc:
	ldoc .

node.all: node.run node.test node.doc
node.run:
	node --watch-path=./src/ ./src/index.js
node.test:
	node --test
node.doc:
	jdoc ./src/index.js

php.run:
	php ./src/index.php
php.test:
	./vendor/bin/phpunit tests
php.serve:
	php -S localhost:8000 -t ./src
php.e2e:
	parallel ::: 'make php.serve' 'curl localhost:8000'
php.trap:
	(trap 'kill 0' SIGINT; make serve & make clocal & wait)

rust.all: rust.run rust.test
rust.run:
	cargo run
rust.test:
	cargo nextest run


zig.all: zig.run zig.test
zig.run:
	zig run ./src/main.zig
zig.test:
	zig test ./src/main.zig
