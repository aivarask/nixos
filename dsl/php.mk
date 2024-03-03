# https://docs.phpunit.de/en/10.5/

php.test:
	./vendor/bin/phpunit tests
php.run:
	php ./src/index.php
php.serve:
	php -S localhost:8000 -t ./src
php.e2e:
	parallel ::: 'make php.serve' 'curl http://localhost:8000'
php.trap:
	(trap 'kill 0' SIGINT; make serve & make clocal & wait)
php.doc: # phpdocumentor
	phpdoc run -t ./doc/phpdoc  -d ./src && parallel ::: 'serve ./doc/phpdoc' 'sleep 1; firefox http://localhost:3000'

