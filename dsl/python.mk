# https://docs.python.org/3/
# https://docs.pytest.org/en/8.0.x/contents.html
# https://docs.python.org/3/library/pydoc.html#module-pydoc

py.test:
	pytest ./dsl/py_*.py
py.run:
	python ./dsl/python.py
py.doc:
	pydoc ./dsl/python.py 
py.clean:
	rm -rf ./.pytest_cache **/__pycache__
py.all: py.test py.run py.clean
