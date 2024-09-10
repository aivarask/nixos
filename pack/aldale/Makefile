mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

ins:
	echo $(mkfile_dir) $(mkfile_path) $(current_dir)

unit: # https://phpunit.de/getting-started/phpunit-11.html
	./vendor/bin/phpunit ./sql
t0:
	parallel -j0 --halt now,done=0 --u ::: "make serve" "pytest"
serve:
	php -S localhost:8000 -a -t=$(mkfile_dir) -c=php.ini
ws: # http://websocketd.com/
	websocketd --port=8080 --loglevel=fatal $(mkfile_dir)ws $(mkfile_dir)
sw:
	parallel --u ::: 'make ws' 'make serve'
t2w:
	parallel -j0 --halt now,done=2 --u ::: "make sw" "pytest-watch --ext=.py,.twig,.php,.ini,.js"
cl:
	fuser -k 8000/tcp 8080/tcp

# https://gettransfer.lt
# https://gettransfer.lt:2222/CMD_FILE_MANAGER

# https://www.sqlitetutorial.net/sqlite-php/connect/
# https://www.php.net/manual/en/class.sqlite3.php
db: # http://127.0.0.1:8080/ https://github.com/coleifer/sqlite-web
	sqlite_web $(DB)
	
# https://twig.symfony.com/doc/3.x/ 
# https://twig.symfony.com/doc/3.x/#reference
# https://luxurydrivers.lt/
