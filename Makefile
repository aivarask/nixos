# https://github.com/casey/just
all: c.all go.all

c.all: c.run
c.lint: 
	clang ./src/main.c -fsyntax-only
c.test:
	clang-check ./src/main.c --analyze --
c.run:
	clang ./src/main.c && ./a.out; rm a.out

go.all: go.run go.test
go.run:
	go run ./src/main.go
go.test:
	go test
go.debug:
	dlv debug
go.doc:
	parallel ::: 'godoc -http=localhost:6060' 'sleep 1; firefox http://localhost:6060/pkg/nixos'

lua.all: lua.run lua.test lua.doc
lua.run:
	lua ./lua/init.lua
lua.test:
	busted
lua.doc:
	ldoc -d ./doc/ldoc ./lua && parallel ::: 'serve ./doc/ldoc' 'sleep 1; firefox http://localhost:3000'

node.all: node.run node.test node.doc
node.run:
	node --watch-path=./src/ ./src/index.js
node.test:
	node --test
node.doc:
	jsdoc -d ./doc/jsdoc ./src/*.js && parallel ::: 'serve ./doc/jsdoc' 'sleep 1; firefox http://localhost:3000'

php.run:
	php ./src/index.php
php.test:
	./vendor/bin/phpunit tests
php.serve:
	php -S localhost:8000 -t ./src
php.e2e:
	parallel ::: 'make php.serve' 'curl http://localhost:8000'
php.trap:
	(trap 'kill 0' SIGINT; make serve & make clocal & wait)
php.doc: # phpdocumentor
	phpdoc run -t ./doc/phpdoc  -d ./src && parallel ::: 'serve ./doc/phpdoc' 'sleep 1; firefox http://localhost:3000'

py.all: py.run py.test
py.run:
	python ./src
py.test:
	pytest

rust.all: rust.run rust.test
rust.run:
	cargo run
rust.test:
	cargo nextest run
rust.doc:
	cargo doc --open

sql.dump:
	mysqldump test --no-data > ./sql/dump.sql
sql.show:
	mysql test -e 'show tables;'
sql.describe:
	mysql test -e 'describe User; describe Address'
sql.alter: 
	mysql test < ./sql/alter.sql
sql.User:
	mysql test < ./sql/User.sql
sql.in.A:
	mysql test < ./sql/Address.sql
sql.sel.A:
	mysql test -e 'select * from Address;'

zig.all: zig.run zig.test
zig.run:
	zig run ./src/main.zig
zig.test:
	zig test ./src/main.zig
