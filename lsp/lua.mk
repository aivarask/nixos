# https://lua.org/
# https://stevedonovan.github.io/ldoc/manual/doc.md.html
# https://github.com/lunarmodules/busted

lua.test:
	busted ./dsl/lua_spec.lua
lua.run:
	lua ./dsl/lua_spec.lua
lua.doc:
	ldoc -d ./docs/ldoc ./dsl/lua_spec.lua
lua.all: lua.run lua.test lua.doc
