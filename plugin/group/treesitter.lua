if not pcall(require, 'nvim-treesitter') then
  return
end

vim.cmd([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set nofoldenable
]])

require('nvim-treesitter.configs').setup({ -- nvim-treesitter
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'tt',
      node_incremental = '<Tab>',
      scope_incremental = 'ti',
      node_decremental = '<S-Tab>',
    },
  },
  matchup = { enable = true }, -- vim-matchup
  endwise = { enable = true }, -- nvim-treesitter-endwise
  autotag = {                  -- nvim-ts-autotag
    enable = true,
    filetypes = { 'templ', 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'xml', 'php', 'markdown' },
  },
  -- nvim-treesitter-context plugin
  -- nvim-ts-context-commentstring plugin
  textobjects = { -- nvim-treesitter-textobjects
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        -- ['ax'] = '@attribute.outer',
        -- ['aX'] = '@block.outer',
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V',  -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = true,
    },
    -- TODO: swap config
    swap = {
      enable = true,
      swap_next = {
        ['>x'] = '@attribute.outer',
        ['>X'] = '@block.outer',
        ['>p'] = '@parameter.inner',
        ['>c'] = '@class.outer',
        ['>f'] = '@function.outer',
      },
      swap_previous = {
        ['<x'] = '@attribute.outer',
        ['<X'] = '@block.outer',
        ['<p'] = '@parameter.inner',
        ['<c'] = '@class.outer',
        ['<f'] = '@function.outer',
      },
    },
    -- TODO: move config
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']x'] = '@attribute.outer',
        [']X'] = '@block.outer',
        [']c'] = '@class.outer',
        [']f'] = '@function.outer',
      },
      goto_previous_start = {
        ['[x'] = '@attribute.outer',
        ['[X'] = '@block.outer',
        ['[c'] = '@class.outer',
        ['[f'] = '@function.outer',
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
})
