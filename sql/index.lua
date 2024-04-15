-- local dbfile = 'index.db'
-- io.open('index.db', 'w'):close()

-- https://zadzmo.org/code/luadbi/wiki/Quickstart.md
DBI = require "DBI"
dbd, err = DBI.Connect('SQLite3', '/etc/nixos/sql/_.db')
assert(dbd, err)
dbd:autocommit(true)

local file = io.open('/etc/nixos/sql/index.sql', "r"):read("*a")

for w in file:gmatch("(.-);") do
  print(w)
  statement, err = dbd:prepare(w)
  assert(statement, err)
  statement:execute()
end


-- local sqlite = require "sqlite.db" --- for constructing sql databases
-- local tbl = require "sqlite.tbl"   --- for constructing sql tables
