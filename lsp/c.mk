c.lint: 
	clang ./dsl/c.c -fsyntax-only
c.test:
	clang-check ./dsl/c.c --analyze --
c.run:
	clang ./dsl/c.c && ./a.out; rm a.out
c.all: c.lint c.test c.run
