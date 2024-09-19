require('nvim-surround').setup({})
local wk = require('which-key')
wk.setup({
  preset = 'helix',
  sort = { 'alphanum' },
  replace = {
    desc = {
      { '<Plug>%(?(.*)%)?', '%1' },
      { '^%+', '' },
      { '<[cC]md>', '' },
      { '<[cC][rR]>', '' },
      { '<[sS]ilent>', '' },
      { '^lua%s+', '' },
      { '^call%s+', '' },
      { '^?:Telescope%s', '' },
      { '^?:Trouble%s', '' },
      { '^ToggleTerm? ', '' },
      { '^exec? ', '' },
      { '^:%s*', '' },
    },
  },
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('help_window_right', {}),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then
      if vim.o.columns > 120 then
        vim.cmd.wincmd('L')
      end
      if vim.fn.winwidth(0) < 100 then
        vim.cmd([[wincmd T]])
      end
    end
  end,
})

vim.cmd([[
map <leader><leader>m :messages<CR>
map <leader><leader>c :call Ctoggle()<CR>
map <silent> [c :cprevious<CR>
map <silent> ]c :cnext<CR>
" map <leader><leader>s :Subvert/<C-r><C-w>//g<Left><Left>
" map <leader><leader>S :%Subvert/<C-r><C-w>//g<Left><Left>
map <silent> <leader><leader>a :call SaveExec()<CR>
map <leader><leader>+ "+y
map <leader><leader>t :tabnew<CR>
map <leader><leader>T :tabclose<CR>
map ]T :tabclose<CR>
map ]t :tabnext<CR>
map [t :tabprevious<CR>
map <leader><leader>i :InspectTree<CR>
map <leader><leader>I :Inspect<CR>
nmap <M-c> gcc
imap <M-c> <C-O>gcc
vmap <M-c> gc
]])

local gitsigns = require('gitsigns')
gitsigns.setup({ signcolumn = false })
wk.add({
  { '<leader>h', group = 'gitsigns' },
  {
    '<leader>hb',
    function()
      gitsigns.blame_line({ full = true })
    end,
    desc = 'blame_line',
  },
  {
    '<leader>hB',
    gitsigns.toggle_current_line_blame,
    desc = 'toggle_current_line_blame',
  },
  {
    '<leader>hD',
    function()
      gitsigns.diffthis('~')
    end,
    desc = 'diffthis ~',
  },
  { '<leader>hd', gitsigns.diffthis, desc = 'diffthis' },
  {
    '<leader>hi',
    [[:<C-U>Gitsigns select_hunk<CR>]],
    desc = 'select_hunk',
    mode = { 'o', 'x' },
  },
  {
    '<leader>hn',
    function()
      gitsigns.nav_hunk('next')
    end,
    desc = 'Hunk next',
  },
  { '<leader>hN', gitsigns.nav_hunk, desc = 'nav_hunk' },
  {
    '<leader>hp',
    function()
      gitsigns.nav_hunk('prev')
    end,
    desc = 'Hunk prev',
  },
  { '<leader>hP', gitsigns.preview_hunk, desc = 'preview_hunk' },
  {
    '<leader>hr',
    function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end,
    desc = 'reset_hunk',
    mode = 'v',
  },
  { '<leader>hR', gitsigns.reset_buffer, desc = 'reset_buffer' },
  { '<leader>hr', gitsigns.reset_hunk, desc = 'reset_hunk' },
  {
    '<leader>hs',
    function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end,
    desc = 'stage_hunk',
    mode = 'v',
  },
  { '<leader>hS', gitsigns.stage_buffer, desc = 'stage_buffer' },
  { '<leader>hs', gitsigns.stage_hunk, desc = 'stage_hunk' },
  {
    '<leader>htd',
    gitsigns.toggle_deleted,
    desc = 'toggle_deleted',
  },
  {
    '<leader>hu',
    gitsigns.undo_stage_hunk,
    desc = 'undo_stage_hunk',
  },
})

wk.add({
  { '<leader>l', group = 'LSP,LG,LF' },
  {
    '<leader>lc',
    function()
      io.popen('echo > ' .. vim.lsp.get_log_path())
    end,
    desc = 'LspLogClear',
  },
  { '<leader>lf', [[:LfCurrentDirectory<CR>]] },
  { '<leader>lg', [[:LazyGit<CR>]] },
  { '<leader>li', [[:LspInfo<CR>]] },
  { '<leader>ll', [[:LspLog<CR>]] },
  { '<leader>lr', [[:LspRestart<CR>]] },
  { '<leader>ls', [[<cmd>LspStart<CR>]] },
  { '<leader>lS', [[<cmd>LspStop<CR>]] },
  { '<leader>lt', [[:LfNewTab<CR>]] },
  { '<leader>lw', [[:LfWorkingDirectory<CR>]] },
})

-- neotest = require "neotest"
-- wk.add {
-- 	{ "<leader>n",  group = "neotest", },
-- 	{ "<leader>nA", function() neotest.run.run { suite = true, strategy = "dap", } end,      desc = "suite dap", },
-- 	{ "<leader>na", function() neotest.run.run { suite = true, } end,                        desc = "suite", },
-- 	{ "<leader>nB", function() neotest.run.run { vim.fn.expand "%", strategy = "dap", } end, desc = "% dap", },
-- 	{ "<leader>nb", function() neotest.run.run(vim.fn.expand "%") end,                       desc = "%", },
-- 	{ "<leader>nc", neotest.output_panel.clear,                                              desc = "output_panel.clear", },
-- 	{ "<leader>nL", function() neotest.run.run_last { strategy = "dap", } end,               desc = "run_last dap", },
-- 	{ "<leader>nl", function() neotest.run.run_last() end,                                   desc = "run_last", },
-- 	{ "<leader>nn", function() neotest.run.run {} end,                                       desc = "run", },
-- 	{ "<leader>no", neotest.output_panel.toggle,                                             desc = "output_panel.toggle", },
-- 	{ "<leader>nR", function() neotest.run.run { strategy = "dap", } end,                    desc = "run dap", },
-- 	{ "<leader>ns", function() neotest.summary:toggle() end,                                 desc = "summary:toggle", },
-- 	{ "<leader>nt", neotest.watch.toggle,                                                    desc = "watch.toggle", },
-- 	{ "<leader>nW", neotest.watch.stop,                                                      desc = "watch.stop", },
-- 	{ "<leader>nw", neotest.watch.watch,                                                     desc = "watch.watch", },
-- 	{ "<leader>nx", function() neotest.summary:expand(vim.uv.cwd(), true) end,               desc = "summary:expand", },
-- }
require('toggleterm').setup({
  shade_terminals = false,
  size = function(term)
    return term.direction == 'horizontal' and vim.o.lines * 0.4 or (term.direction == 'vertical' and vim.o.columns * 0.3)
  end,
  float_opts = {
    width = function()
      return math.ceil(vim.o.columns * 0.8)
    end,
    height = function()
      return math.ceil(vim.o.lines * 0.8)
    end,
  },
})
local Terminal = require('toggleterm.terminal').Terminal
nix_repl = Terminal:new({ cmd = 'nix repl', hidden = true })
lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

wk.add({ --- @see a_ToggleTerm
  { '<leader>a', group = 'ToggleTerm' },
  {
    '<C-\\>',
    '<cmd>ToggleTerm<CR>',
    mode = { 'n', 'i', 't' },
  },
  {
    '<leader>aa',
    '<cmd>ToggleTerm<CR>',
    mode = { 'n', 'i', 't' },
  },
  {
    '<leader>af',
    '<cmd>ToggleTerm direction=float <CR>',
    mode = { 'n', 'i', 't' },
  },
  {
    '<leader>ah',
    '<cmd>ToggleTerm direction=horizontal<CR>',
    mode = { 'n', 'i', 't' },
  },
  {
    '<leader>an',
    function()
      return nix_repl:toggle()
    end,
    desc = 'nix repl',
  },
  {
    '<leader>al',
    function()
      return lazygit:toggle()
    end,
    desc = 'lazygit',
  },
  {
    '<leader>aR',
    "<cmd>exec 'ToggleTerm direction=tab dir=' .. expand('%:p:h')<CR>",
    mode = { 'n', 'i', 't' },
  },
  {
    '<leader>ar',
    "<cmd>exec 'ToggleTerm direction=vertical dir=' .. expand('%:p:h')<CR>",
    mode = { 'n', 'i', 't' },
  },
  {
    '<leader>at',
    '<cmd>ToggleTerm direction=tab<CR>',
    mode = { 'n', 'i', 't' },
  },
  {
    '<leader>av',
    '<cmd>ToggleTerm direction=vertical<CR>',
    mode = { 'n', 'i', 't' },
  },
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('Keymaps', {}),
  pattern = 'toggleterm',
  desc = '<esc> <C-\\><C-n>',
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  end,
})
