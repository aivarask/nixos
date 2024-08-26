local ftmap = require "null-ls.builtins._meta.filetype_map".python
local python = {
  code_actions = { "refactoring", },
  diagnostics = {
    "bandit",
    "flake8",
    "mypy",
    "pycodestyle",
    "pydocstyle",
    "pylama",
    "pylint",
    "pyproject_flake8",
    "ruff",
    "semgrep",
    "vulture",
  },
  formatting = {
    "autoflake",
    "autopep8",
    "black",
    "blackd",
    "blue",
    "docformatter",
    "dprint",
    "isort",
    "isortd",
    "pyflyby",
    "pyink",
    "reorder_python_imports",
    "ruff",
    "ruff_format",
    "usort",
    "yapf",
  },
}
require "null-ls".register {
  require "null-ls.builtins.formatting.black",
}

local pyright = require "lspconfig.server_configurations.pyright"
require "lspconfig".pyright.setup {}

vim.api.nvim_create_autocmd({ "BufWritePre", }, {
  group = "Format",
  desc = "pyright",
  pattern = { "*.py", },
  callback = function() vim.lsp.buf.format() end,
})

require "dap-python".setup "python"

-- require('dap').configurations.python = {
--   {
--     type = 'python',
--     request = 'launch',
--     name = 'python file',
--     program = '${file}',
--   },
-- }
