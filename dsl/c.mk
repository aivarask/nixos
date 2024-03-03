c.all: c.run
c.lint: 
	clang ./src/main.c -fsyntax-only
c.test:
	clang-check ./src/main.c --analyze --
c.run:
	clang ./src/main.c && ./a.out; rm a.out
