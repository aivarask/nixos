# https://twig.symfony.com/doc/3.x/
# https://www.sqlitetutorial.net/sqlite-php/connect/
# https://www.php.net/manual/en/class.sqlite3.php
# https://symfony.com/doc/current/setup.html

unit: # https://phpunit.de/getting-started/phpunit-11.html
	./vendor/bin/phpunit ./tests
serve:
	php -S localhost:8000 -a -t=src -c=src/php.ini

t0:
	parallel -j0 --halt now,done=0 --u ::: "make serve" "pytest"

t2w:
	parallel -j0 --halt now,done=2 --u ::: "make serve" "pytest-watch --ext=.py,.twig,.php,.ini"

# https://gettransfer.lt
# https://gettransfer.lt:2222/CMD_FILE_MANAGER

db: # http://127.0.0.1:8080/ https://github.com/coleifer/sqlite-web
	sqlite_web $(DB)
