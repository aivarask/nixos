sql.dump:
	mysqldump test --no-data > ./sql/dump.sql
sql.show:
	mysql test -e 'show tables;'
sql.describe:
	mysql test -e 'describe User; describe Address'
sql.alter: 
	mysql test < ./sql/alter.sql
sql.User:
	mysql test < ./sql/User.sql
sql.in.A:
	mysql test < ./sql/Address.sql
sql.sel.A:
	mysql test -e 'select * from Address;'

sql.bench:
	hyperfine --runs 5 'php sql/index.php' 'lua sql/index.lua' 'node sql/index.js' 'python sql/index.py' 'cargo run sql/index.rs' 'go run sql/index.go'

sql.bin:
	hyperfine --runs 5 'lua sql/index.lua' 'target/debug/main' './index'
