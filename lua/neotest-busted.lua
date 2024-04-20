local lib = require("neotest.lib")
local pr = require('pl.pretty')

--- @type neotest.Adapter
local a = {
  name = 'busted',
  root = function(dir)
    return vim.uv.cwd()
  end,
}

function a.filter_dir(name)
  return name == 'spec'
end

---@async
---@param file_path string
---@return boolean
function a.is_test_file(file_path)
  return file_path:match('_spec')
end

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function a.discover_positions(file_path)
  local query = [[
  ;;query
  ;; describe blocks
  ((function_call
      name: (identifier) @func_name (#match? @func_name "^describe$")
      arguments: (arguments (_) @namespace.name (function_definition))
  )) @namespace.definition


  ;; it blocks
  ((function_call
      name: (identifier) @func_name
      arguments: (arguments (_) @test.name (function_definition))
  ) (#match? @func_name "^it$")) @test.definition

  ;; async it blocks (async.it)
  ((function_call
      name: (
        dot_index_expression
          field: (identifier) @func_name
      )
      arguments: (arguments (_) @test.name (function_definition))
    ) (#match? @func_name "^it$")) @test.definition
    ]]
  -- treesitter-query
  return lib.treesitter.parse_positions(file_path, query, { nested_namespaces = true })
end

---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function a.build_spec(args)
  if not args.tree then return end
  local pos = args.tree:data()

  if pos.type == "dir" then return end
  if pos.type ~= "test" then return end

  ---@type neotest.RunSpec
  return {
    command = { 'busted' },
    -- command = { 'busted', '--filter',  pos.name },
    context = { pos = pos },
    -- strategy = require('dap').configurations.javascript[1],
  }
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function a.results(spec, result, tree)
  local pos_id = spec.context.pos.id

  ---@type table<string, neotest.Result>
  return { [pos_id] = { status = result.code == 0 and "passed" or "failed" } }
end

return a
