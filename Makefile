# https://makefiletutorial.com/#multiple-targets
include ./dsl/*.mk
include ./sql/*.mk

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
