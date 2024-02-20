# https://stackoverflow.com/questions/3004811/how-do-you-run-multiple-programs-in-parallel-from-a-bash-script#5553774

php:
	php index.php

check:
	curl example.org

serve:
	php -S 127.0.0.1:8000

clocal:
	curl localhost:8000

test:
	(trap 'kill 0' SIGINT; make serve & make clocal & wait)

p:
	(make serve; make cheack) | parallel

pa:
	(make serve & make check) | parallel

pb:
	parallel ::: 'php -S localhost:8000' 'curl example.org'

# C
gcc:
	gcc -fsyntax-only ./plugin/lang/c.c

cc:
	cc -fsyntax-only ./plugin/lang/c.c

clang: 
	clang --analyze ./plugin/lang/c.c
