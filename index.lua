local dbfile = 'index.db'
io.open('index.db', 'w'):close()

-- https://zadzmo.org/code/luadbi/wiki/Quickstart.md
DBI = require "DBI"
dbd, err = DBI.Connect('SQLite3', 'index.db')
assert(dbd, err)

dbd:autocommit(true)

statement, err = dbd:prepare("CREATE TABLE t1 (id INT, c1 TEXT, c2 INT);")
assert(statement, err)
statement:execute()


statement, err = dbd:prepare("INSERT INTO t1 VALUES(1, 'v1', " .. 1 .. ");")
assert(statement, err)
statement:execute()

statement, err = dbd:prepare("select * from t1 where id = $1;")
assert(statement, err)
statement:execute(1)

for row in statement:rows(true) do
  print(row['id'])
  print(row['c1'])
  print(row['c2'])
end
