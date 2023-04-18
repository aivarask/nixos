-- https://github.com/folke/which-key.nvim
vim.o.timeout = true
vim.o.timeoutlen = 200
-- require('which-key').setup()
function GoGithub()
  -- "github:nix-community/neovim-nightly-overlay";
  local pre = 'https://github.com/'
  local word = vim.fn.expand('<cWORD>')
  word = word:gsub('github:', pre)
  word = word:gsub(';', '')
  vim.cmd('!xdg-open ' .. word)
end
vim.keymap.set('n', '<leader>gg', GoGithub)

wkr({
  ['<leader>'] = {
    ['?'] = { require('which-key').show, 'Whick key' },
  },
  ['<F1>'] = {
    function()
      vim.cmd.help(vim.fn.expand('<cword>'))
    end,
    'vim.cmd.help <cword>',
  },
  ['<F13>'] = {
    function()
      vim.cmd.help(vim.fn.expand('<cWORD>'))
    end,
    'vim.cmd.help <cWORD>',
  },
  ['<F25>'] = {
    function()
      vim.cmd.help(vim.fn.expand('<cexpr>'))
    end,
    'vim.cmd.help <cexpr>',
  },
  ['<leader>g'] = {
    x = {
      function()
        local arg = vim.fn.escape(vim.fn.expand('<cfile>'), '#')
        vim.cmd([[!xdg-open ]] .. arg)
      end,
      '!xdg-open <cfile>',
    },
    h = {
      function()
        vim.cmd([[!nix eval nixpkgs\#]] .. vim.fn.expand('<cword>') .. [[.meta.homepage | xargs xdg-open]])
      end,
      '!nix eval nixpkgs#<cword>.meta.homepage | xargs xdg-open',
    },
    H = {
      function()
        vim.cmd([[!nix eval nixpkgs\#]] .. vim.fn.expand('<cWORD>') .. [[.meta.homepage | xargs xdg-open]])
      end,
      '!nix eval nixpkgs#<cWORD>.meta.homepage | xargs xdg-open',
    },
    g = { GoGithub, 'github:owner/repo' },
  },
  ['<leader>t'] = {
    name = 'Telescope',
    x = {
      function()
        require('telescope.builtin').find_files({ cwd = '/etc/nixos/vim/plugin' })
      end,
      'find_files /etc/nixos/vim/plugin',
    },
    t = { '<cmd>Telescope<cr>', 'Telescope' },
    b = { [[:Telescope buffers<CR>]], 'buffers' },
    k = { [[:Telescope keymaps<CR>]], 'keymaps' },
    h = { [[:Telescope help_tags<CR>]], 'helptags' },
    f = { [[:Telescope find_files<CR>]], 'find_files' },
    g = { [[:Telescope live_grep<CR>]], 'live_grep' },
    l = {
      name = 'LSP',
      d = { [[:Telescope lsp_document_symbols<CR>]], 'lsp_document_symbols' },
      w = { [[:Telescope lsp_workspace_symbols<CR>]], 'lsp_workspace_symbols' },
      x = { [[:Telescope lsp_dynamic_workspace_symbols<CR>]], 'lsp_dynamic_workspace_symbols' },
    },
  },
})
