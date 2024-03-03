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


