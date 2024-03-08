# https://twig.symfony.com/doc/3.x/
# https://www.sqlitetutorial.net/sqlite-php/connect/
# https://www.php.net/manual/en/class.sqlite3.php
# https://symfony.com/doc/current/setup.html

# https://twig.symfony.com/doc/3.x/
unit: # https://phpunit.de/getting-started/phpunit-11.html
	./vendor/bin/phpunit ./tests
serve:
	php --ini -S 127.0.0.1:8000 -a -t src
# https://symfony.com/doc/current/testing/end_to_end.html
int:
	parallel ::: 'make serve' 'make e2e'
# ---
mirror:
	./mirror.sh

reset:
	fuser -k '8000/tcp'

reload:
	xdotool key --window $(xdotool search --name "Mozilla Firefox") Ctrl+l


	
fm:
	xdg-open https://gettransfer.lt:2222/CMD_FILE_MANAGER
# https://gettransfer.lt

# https://github.com/coleifer/sqlite-web
db: # http://127.0.0.1:8080/
	sqlite_web $(DB)
