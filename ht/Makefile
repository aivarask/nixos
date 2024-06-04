mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

ht.mirror:
	$(mkfile_dir)/mirror.sh

ht.serve:
	php -S localhost:8000 -a -t=$(mkfile_dir) -c=php.ini
