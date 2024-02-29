# C
cc:
	cc -fsyntax-only ./src/main.c
gcc:
	gcc -fsyntax-only ./src/main.c
ccompile: 
	clang --analyze ./src/main.c
crun:
	clang -o ./src/mainc ./src/main.c; ./src/mainc

# PHP
serve:
	php -S localhost:8000 -t ./src
test:
	parallel ::: 'make serve' 'curl localhost:8000'
trap:
	(trap 'kill 0' SIGINT; make serve & make clocal & wait)
