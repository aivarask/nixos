# https://docs.phpunit.de/en/10.5/
# https://docs.phpdoc.org/3.0/

php.test:
	./vendor/bin/phpunit ./sql/indexTest.php
php.run:
	php ./dsl/php.php
php.doc: # phpdocumentor
	phpdoc run -t ./docs/phpdoc  -d ./dsl
php.clean:
	rm -rf ./.phpdoc
php.all: php.test php.run php.doc

