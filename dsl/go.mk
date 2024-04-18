# https://go.dev/
# https://go.dev/doc/tutorial/add-a-test
# https://pkg.go.dev/cmd/go#hdr-Testing_flags
# https://github.com/go-delve/delve

go.test:
	go test sql/go_test.go --run test
go.run:
	go run sql/index.go
go.debug:
	dlv debug
go.doc:
	godoc -http=localhost:6060

go.all: go.test go.run
