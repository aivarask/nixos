# https://twig.symfony.com/doc/3.x/
# https://www.sqlitetutorial.net/sqlite-php/connect/
# https://www.php.net/manual/en/class.sqlite3.php

mirror:
	./mirror.sh

serve:
	php -S 127.0.0.1:8000 -a

reset:
	fuser -k '8000/tcp'

reload:
	xdotool key --window $(xdotool search --name "Mozilla Firefox") Ctrl+l

unit: # https://phpunit.de/getting-started/phpunit-11.html
	./vendor/bin/phpunit ./tests

e2e: # https://symfony.com/doc/current/testing/end_to_end.html
	php ./e2e.php

int:
	parallel ::: 'make serve' 'make e2e'
	
fm:
	xdg-open https://gettransfer.lt:2222/CMD_FILE_MANAGER
# https://gettransfer.lt

# https://github.com/coleifer/sqlite-web
db: # http://127.0.0.1:8080/
	sqlite_web $(DB)

test:
	echo 'foo' $(DB)
