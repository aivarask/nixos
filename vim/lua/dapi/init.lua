require('dapi.config')
-- mfussenegger/nvim-dap
-- dap.txt

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- require("dapui").setup()
-- local dap = require("dap")

map('n', '<space>b', ':lua require"dap".toggle_breakpoint()<CR>')
map('n', '<space>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

map('n', '<space>k', ':lua require"dap".step_out()<CR>')
map('n', '<space>l', ':lua require"dap".step_into()<CR>')
map('n', '<space>j', ':lua require"dap".step_over()<CR>')
map('n', '<space>h', ':lua require"dap".continue()<CR>')

map('n', '<space>dn', ':lua require"dap".run_to_cursor()<CR>')
map('n', '<space>dk', ':lua require"dap".up()<CR>')
map('n', '<space>dj', ':lua require"dap".down()<CR>')
map('n', '<space>dc', ':lua require"dap".close()<CR>')
map('n', '<space>dt', ':lua require"dap".terminate()<CR>')
-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L602
map('n', '<space>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
map('n', '<space>rc', ':lua require"dap".repl.close()<CR>')
map('n', '<space>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>')
map('n', '<space>da', ':lua require"dhelp".attach()<CR>')
map('n', '<space>dA', ':lua require"dhelp".attachToRemote()<CR>')
-- Widgets
map('n', '<space>di', ':lua require"dap.ui.widgets".hover()<CR>')
map('n', '<space>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt#L715
local widgets = require('dap.ui.widgets')
-- https://github.com/nanotee/nvim-lua-guide#tips-3
-- Scopes
local scopes_widget = widgets.sidebar(widgets.scopes)
function _G.toggle_scopes()
  scopes_widget.toggle()
end

map('n', '<F10>', ':lua toggle_scopes()<CR>')
-- Frames
local frames_widget = widgets.sidebar(widgets.frames)
function _G.toggle_frames()
  frames_widget.toggle()
end

map('n', '<F9>', ':lua toggle_frames()<CR>')
-- Expression
local expression_widget = widgets.sidebar(widgets.expression)
function _G.toggle_expression()
  expression_widget.toggle()
end

map('n', '<F8>', ':lua toggle_expression()<CR>')

require('nvim-dap-virtual-text').setup({})
