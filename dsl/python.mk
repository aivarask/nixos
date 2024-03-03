
py.test:
	pytest ./dsl/py_test.py
py.run:
	python ./dsl/python.py
py.doc:
	py
py.all: py.run py.test

