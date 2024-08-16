-- NOTE: https://vi.stackexchange.com/questions/22129/which-keys-are-free-unmapped-by-default-in-vim
vim.cmd [[
if !exists('*SaveExec')
  function! SaveExec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif
    return
  endfunction
endif

function! Ctoggle()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

]]

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt", },
  callback = function() if vim.o.filetype == 'help' and vim.o.columns > 120 then vim.cmd.wincmd "L" end end,
})

-- require 'nvim-surround'.setup {}
wk = require "which-key"
wk.setup { preset = 'helix', sort = { "alphanum", }, }

wk.add {
  { '-',    '<cmd>cd ..<CR>', },
  { '<F1>', function() vim.cmd.help(vim.fn.expand '<cword>') end, desc = 'help <cword>', },
  { 'qq',   [[:NvimTreeToggle<CR>]],                              desc = 'NvimTreeToggle',   noremap = true, },
  { 'qw',   [[:NvimTreeCollapse<CR>]],                            desc = 'NvimTreeCollapse', },
}

vim.cmd [[
map <leader><leader>m :messages<CR>
map <leader><leader>q :quitall<CR>
map <leader><leader>c :call Ctoggle()<CR>
map <silent> [c :cprevious<CR>
map <silent> ]c :cnext<CR>
map <leader><leader>s :Subvert/<C-r><C-w>//g<Left><Left>
map <leader><leader>S :%Subvert/<C-r><C-w>//g<Left><Left>
map <leader><leader>a :call SaveExec()<CR>
map <leader><leader>+ "+y
map <leader><leader>t :tabnew<CR>
map <leader><leader>T :tabclose<CR>
map ]t :tabnext<CR>
map [t :tabprevious<CR>
map <leader><leader>i :InspectTree<CR>
map <leader><leader>I :Inspect<CR>
]]

wk.add {
  { '<leader>H',  group = 'checkhealth', },
  { '<leader>HH', '<cmd>checkhealth<CR>', },
  { '<leader>Hw', '<cmd>checkhealth which-key<CR>', },
}

dap = require 'dap'
dapui = require 'dapui'
widgets = require 'dap.ui.widgets'
require 'persistent-breakpoints'.setup { load_breakpoints_event = { "BufReadPost", }, }
wk.add {
  { '<leader>d',   group = 'DAP', },
  { '<leader>da',  dap.attach,                                            desc = 'attach', },
  { '<leader>dB',  dap.step_back,                                         desc = 'step_back', },
  { '<leader>db',  group = 'breakpoint', },
  { '<leader>dbc', dap.clear_breakpoints,                                 desc = 'clear_breakpoints', },
  { '<leader>dbl', dap.list_breakpoints,                                  desc = 'list_breakpoints', },
  { '<leader>dbs', dap.set_breakpoint,                                    desc = 'set_breakpoint', },
  { '<leader>dbt', dap.toggle_breakpoint,                                 desc = 'toggle_breakpoint', },
  { '<leader>dbx', dap.set_exception_breakpoints,                         desc = 'set_exception_breakpoints', },
  { '<leader>dc',  dap.continue,                                          desc = 'continue', },
  { '<leader>dC',  dap.reverse_continue,                                  desc = 'reverse_continue', },
  { '<leader>dd',  dap.disconnect,                                        desc = 'disconnect', },
  { '<leader>df',  group = 'frame', },
  { '<leader>dff', dap.focus_frame,                                       desc = 'focus_frame', },
  { '<leader>dfr', dap.restart_frame,                                     desc = 'restart_frame', },
  { '<leader>dL',  dap.launch,                                            desc = 'launch', },
  { '<leader>dl',  dap.run_last,                                          desc = 'run_last', },
  { '<leader>dp',  dap.pause,                                             desc = 'pause', },
  { '<leader>dR',  dap.restart,                                           desc = 'restart', },
  { '<leader>dr',  dap.run,                                               desc = 'run', },
  { '<leader>dS',  dap.status,                                            desc = 'status', },
  { '<leader>ds',  group = 'step', },
  { '<leader>dsh', dap.step_out,                                          desc = 'out', },
  { '<leader>dsj', dap.step_over,                                         desc = 'over', },
  { '<leader>dsk', dap.step_back,                                         desc = 'back', },
  { '<leader>dsl', dap.step_into,                                         desc = 'into', },
  { '<leader>dT',  dap.repl.toggle,                                       desc = 'repl.toggle', },
  { '<leader>dt',  function() dapui.toggle { reset = true, } end,         desc = 'dapui.toggle', },
  { '<leader>dU',  dap.down,                                              desc = 'down', },
  { '<leader>du',  dap.up,                                                desc = 'up', },
  { '<leader>dw',  widgets.hover,                                         desc = 'widgets.hover', },
  { '<leader>dW',  widgets.preview,                                       desc = 'widgets.preview', },
  { '<leader>dx',  dap.run_to_cursor,                                     desc = 'run_to_cursor', },
  { '<leader>dX',  function() widgets.centered_float(widgets.scopes) end, desc = 'widgets.scopes', },
  { '<leader>dz',  dap.close,                                             desc = 'close', },
  { '<leader>dZ',  dap.terminate,                                         desc = 'terminate', },
}

local p = [[!nix eval nixos\#nixosConfigurations.]]
local h = vim.uv.os_gethostname()
local w = function() return vim.fn.expand '<cword>' end
string.open = function(v) vim.cmd('!xdg-open ' .. v) end
wk.add {
  { '<leader>g',  group = 'xdg-open',                                                                                          desc = 'xdg-open', },
  { '<leader>gc', function() vim.cmd([[!composer browse ]] .. vim.fn.expand '<cWORD>':gsub(':', '')) end,                      desc = 'composer browse', },
  { '<leader>gd', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.description | xargs notify-send') end,                desc = 'description', },
  { '<leader>gD', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. [[.meta.longDescription --raw | xargs -0 notify-send]]) end, desc = 'longDescription', },
  { '<leader>gg', function() vim.fn.expand '<cWORD>':gsub('github:', 'https://github.com/'):gsub(';', ''):open() end,          desc = 'github:owner/repo', },
  { '<leader>gh', function() vim.cmd(p .. h .. '.pkgs.' .. w() .. '.meta.homepage | xargs xdg-open') end,                      desc = 'meta.homepage', },
  { '<leader>gl', function() vim.cmd(p .. h .. '.pkgs.luajitPackages.' .. w() .. '.meta.homepage | xargs xdg-open') end,       desc = 'luajitPackages', },
  { '<leader>gm', function() vim.cmd([[!xdg-open "https://mynixos.com/search?q=]] .. vim.fn.expand '<cword>' .. '"') end,      desc = 'mynixos', },
  { '<leader>gn', function() vim.cmd(p .. h .. '.pkgs.nodePackages.' .. w() .. '.meta.homepage | xargs xdg-open') end,         desc = 'nodePackages', },
  { '<leader>gP', function() vim.cmd(p .. h .. '.pkgs.php81Extensions.' .. w() .. '.meta.homepage | xargs xdg-open') end,      desc = 'php81Extensions', },
  { '<leader>gp', function() vim.cmd(p .. h .. '.pkgs.php81Packages.' .. w() .. '.meta.homepage | xargs xdg-open') end,        desc = 'php81Packages', },
  { '<leader>gv', function() vim.cmd(p .. h .. '.pkgs.vimPlugins.' .. w() .. '.meta.homepage | xargs xdg-open') end,           desc = 'vimPlugins', },
}

gitsigns = require 'gitsigns'
gitsigns.setup { signcolumn = false, }
wk.add {
  { '<leader>h',   group = 'gitsigns', },
  { '<leader>hb',  function() gitsigns.blame_line { full = true, } end,                      desc = 'blame_line', },
  { '<leader>hB',  gitsigns.toggle_current_line_blame,                                       desc = 'toggle_current_line_blame', },
  { '<leader>hD',  function() gitsigns.diffthis '~' end,                                     desc = 'diffthis ~', },
  { '<leader>hd',  gitsigns.diffthis,                                                        desc = 'diffthis', },
  { '<leader>hi',  [[:<C-U>Gitsigns select_hunk<CR>]],                                       desc = 'select_hunk',               mode = { 'o', 'x', }, },
  { '<leader>hn',  function() gitsigns.nav_hunk 'next' end,                                  desc = 'Hunk next', },
  { '<leader>hN',  gitsigns.nav_hunk,                                                        desc = 'nav_hunk', },
  { '<leader>hp',  function() gitsigns.nav_hunk 'prev' end,                                  desc = 'Hunk prev', },
  { '<leader>hP',  gitsigns.preview_hunk,                                                    desc = 'preview_hunk', },
  { '<leader>hr',  function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v', } end, desc = 'reset_hunk',                mode = 'v', },
  { '<leader>hR',  gitsigns.reset_buffer,                                                    desc = 'reset_buffer', },
  { '<leader>hr',  gitsigns.reset_hunk,                                                      desc = 'reset_hunk', },
  { '<leader>hs',  function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v', } end, desc = 'stage_hunk',                mode = 'v', },
  { '<leader>hS',  gitsigns.stage_buffer,                                                    desc = 'stage_buffer', },
  { '<leader>hs',  gitsigns.stage_hunk,                                                      desc = 'stage_hunk', },
  { '<leader>htd', gitsigns.toggle_deleted,                                                  desc = 'toggle_deleted', },
  { '<leader>hu',  gitsigns.undo_stage_hunk,                                                 desc = 'undo_stage_hunk', },
}

wk.add {
  { '<leader>l',  group = 'LSP,LG,LF', },
  { '<leader>lc', function() io.popen('echo > ' .. vim.lsp.get_log_path()) end, desc = 'LspLogClear', },
  { '<leader>lf', [[:LfCurrentDirectory<CR>]],                                  desc = 'LfCurrentDirectory', },
  { '<leader>lg', [[:LazyGit<CR>]],                                             desc = 'LazyGit', },
  { '<leader>li', [[:LspInfo<CR>]],                                             desc = 'LspInfo', },
  { '<leader>ll', [[:LspLog<CR>]],                                              desc = 'LspLog', },
  { '<leader>lr', [[:LspRestart<CR>]],                                          desc = 'LspRestart', },
  { '<leader>ls', [[<cmd>LspStart<CR>]],                                        desc = 'LspStart', },
  { '<leader>lS', [[<cmd>LspStop<CR>]],                                         desc = 'LspStop', },
  { '<leader>lt', [[:LfNewTab<CR>]],                                            desc = 'LfNewTab', },
  { '<leader>lw', [[:LfWorkingDirectory<CR>]],                                  desc = 'LfWorkingDirectory', },
}

function on_attach_lsp(client, bufnr)
end

wk.add {
  { '<space>',  group = 'LSP', },
  { '<space>D', vim.lsp.buf.declaration,                        desc = 'declaration', },
  { '<space>d', vim.lsp.buf.definition,                         desc = 'definition', },
  { '<space>e', vim.diagnostic.open_float,                      desc = 'open_float', },
  { '<space>I', function() return vim.lsp.inspect_client() end, desc = 'inspect_client',        noremap = true, },
  { '<space>i', vim.lsp.buf.implementation,                     desc = 'implementation', },
  { '<space>O', [[<cmd>LspOverloadsSignature<CR>]],             desc = 'LspOverloadsSignature', },
  { '<space>o', [[<cmd>Outline<CR>]],                           desc = 'Outline', },
  { '<space>q', vim.diagnostic.setloclist,                      desc = 'setloclist', },
  { '<space>R', vim.lsp.buf.references,                         desc = 'references', },
  { '<space>r', vim.lsp.buf.rename,                             desc = 'rename', },
  { '<space>S', require 'lsp_signature'.toggle_float_win,       desc = 'toggle_float_win', },
  { '<space>s', vim.lsp.buf.signature_help,                     desc = 'signature_help', },
  { '<space>t', vim.lsp.buf.type_definition,                    desc = 'type_definition', },
}

require 'hover'.setup { init = function() require 'hover.providers.lsp' end, } -- hover-nvim
require 'goto-preview'.setup {}                                                -- goto-preview
wk.add {
  { '<leader>p',  group = 'goto-preview', },
  { '<leader>pd', require 'goto-preview'.goto_preview_definition,      desc = 'definition', },
  { '<leader>pt', require 'goto-preview'.goto_preview_type_definition, desc = 'type_definition', },
  { '<leader>pi', require 'goto-preview'.goto_preview_implementation,  desc = 'implementation', },
  { '<leader>pD', require 'goto-preview'.goto_preview_declaration,     desc = 'declaration', },
  { '<leader>pc', require 'goto-preview'.close_all_win,                desc = 'close_all_win', },
  { '<leader>pr', require 'goto-preview'.goto_preview_references,      desc = 'references', },
}

neotest = require 'neotest'
wk.add {
  { '<leader>n',  group = 'neotest', },
  { '<leader>nB', function() neotest.run.run { vim.fn.expand '%', strategy = 'dap', } end, desc = '% dap', },
  { '<leader>nb', function() neotest.run.run(vim.fn.expand '%') end,                       desc = '%', },
  { '<leader>nc', neotest.output_panel.clear,                                              desc = 'output_panel.clear', },
  { '<leader>nL', function() neotest.run.run_last { strategy = 'dap', } end,               desc = 'run_last dap', },
  { '<leader>nl', function() neotest.run.run_last() end,                                   desc = 'run_last', },
  { '<leader>no', neotest.output_panel.toggle,                                             desc = 'output_panel.toggle', },
  { '<leader>nR', function() neotest.run.run { strategy = 'dap', } end,                    desc = 'run dap', },
  { '<leader>ns', function() neotest.run.run { suite = true, } end,                        desc = 'suite', },
  { '<leader>nS', function() neotest.run.run { suite = true, strategy = 'dap', } end,      desc = 'suite dap', },
  { '<leader>nt', neotest.watch.toggle,                                                    desc = 'watch.toggle', },
  { '<leader>nW', neotest.watch.stop,                                                      desc = 'watch.stop', },
  { '<leader>nw', neotest.watch.watch,                                                     desc = 'watch.watch', },
  { '<leader>nx', function() neotest.summary:expand(vim.uv.cwd(), true) end,               desc = 'summary:expand', },
  { '<leader>nX', function() neotest.summary:toggle() end,                                 desc = 'summary:toggle', },
}


require 'toggleterm'.setup {
  shade_terminals = false,
  size = function(term)
    return term.direction == 'horizontal' and vim.o.lines * 0.4 or
        (term.direction == 'vertical' and vim.o.columns * 0.3)
  end,
  float_opts = {
    width = function() return math.ceil(vim.o.columns * 0.8) end,
    height = function() return math.ceil(vim.o.lines * 0.8) end,
  },
}
local Terminal = require 'toggleterm.terminal'.Terminal
nix_repl = Terminal:new { cmd = 'nix repl', hidden = true, }
lazygit = Terminal:new { cmd = "lazygit", hidden = true, }

wk.add {
  { '<leader>a',  group = 'ToggleTerm', },
  { '<leader>aa', '<cmd>ToggleTerm<CR>',                                                   desc = 'ToggleTerm',        mode = { 'n', 'i', 't', }, },
  { '<leader>af', '<cmd>ToggleTerm direction=float <CR>',                                  desc = 'float',             mode = { 'n', 'i', 't', }, },
  { '<leader>ah', '<cmd>ToggleTerm direction=horizontal<CR>',                              desc = 'horizontal',        mode = { 'n', 'i', 't', }, },
  { '<leader>an', function() return nix_repl:toggle() end,                                 desc = 'nix repl', },
  { '<leader>al', function() return lazygit:toggle() end,                                  desc = 'lazygit', },
  { '<leader>aR', "<cmd>exec 'ToggleTerm direction=tab dir=' .. expand('%:p:h')<CR>",      desc = 'relative tab',      mode = { 'n', 'i', 't', }, },
  { '<leader>ar', "<cmd>exec 'ToggleTerm direction=vertical dir=' .. expand('%:p:h')<CR>", desc = 'relative vertical', mode = { 'n', 'i', 't', }, },
  { '<leader>at', '<cmd>ToggleTerm direction=tab<CR>',                                     desc = 'tab',               mode = { 'n', 'i', 't', }, },
  { '<leader>av', '<cmd>ToggleTerm direction=vertical<CR>',                                desc = 'vertical',          mode = { 'n', 'i', 't', }, },
}

vim.api.nvim_create_augroup('ToggleTermKeymaps', { clear = true, })
vim.api.nvim_create_autocmd('FileType', {
  group = 'ToggleTermKeymaps',
  desc = 'keymap.set on filetype toggleterm',
  pattern = 'toggleterm',
  callback = function()
    local opts = { buffer = 0, }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<F11>', [[<cmd>LazyGit<CR>]], opts)
  end,
})
