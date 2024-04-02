local async = require('neotest.async')
local lib = require("neotest.lib")
local nt = require('neotest.types')
local pr = require('pl.pretty')

--- @type neotest.Adapter
local a = { name = 'node' }

function a.root(dir)
  return vim.uv.cwd()
end

function a.filter_dir(name)
  return name == 'dsl'
end

---@async
---@param file_path string
---@return boolean
function a.is_test_file(file_path)
  return file_path:match('node.test.js')
end

---Given a file path, parse all the tests within it.
---@async
---@param file_path string Absolute file path
---@return neotest.Tree | nil
function a.discover_positions(file_path)
  -- treesitter-query
  local query = io.open('/etc/nixos/lua/node.scm', "rb"):read("*a")
  return lib.treesitter.parse_positions(file_path, query, { nested_namespaces = true })
end

-- https://nodejs.org/docs/latest/api/test.html#test-reporters
-- https://github.com/nvim-neotest/neotest
---@param args neotest.RunArgs
---@return nil | neotest.RunSpec | neotest.RunSpec[]
function a.build_spec(args)
  local results_path = async.fn.tempname()
  local tree = args.tree
  if not tree then return end

  local pos = args.tree:data()
  if pos.type == "dir" then return end

  ---@type neotest.RunSpec
  return {
    command = { 'node', '--test' },
    context = {
      results_path = results_path,
      file = pos.path,
    },
  }
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@param tree neotest.Tree
---@return table<string, neotest.Result>
function a.results(spec, result, tree)
  local success, data = pcall(lib.files.read, spec.context.results_path)
  pr(spec, result)

  ---@type neotest.Result
  local results = {}
  return results
end

return a
