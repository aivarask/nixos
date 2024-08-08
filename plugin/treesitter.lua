if not pcall(require, 'nvim-treesitter') then return end
vim.cmd [[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set nofoldenable
]]

require 'treesitter-context'.setup { -- nvim-treesitter-context
  enable = false,
}

vim.g.skip_ts_context_commentstring_module = true
require 'ts_context_commentstring'.setup { -- ts-context-commentstring nvim-ts-context-commentstring
}
require 'nvim-ts-autotag'.setup { filetypes = { "html", 'php', 'twig', 'xml' } }

require 'nvim-treesitter.configs'.setup { -- nvim-treesitter
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "tt",
      node_incremental = "<tab>",
      scope_incremental = "ti",
      node_decremental = "<s-tab>",
    },
  },
  matchup = { enable = true }, -- vim-matchup
  endwise = { enable = true }, -- nvim-treesitter-endwise
  textobjects = {              -- nvim-treesitter-textobjects
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects?#built-in-textobjects
    swap = {                   -- nvim-treesitter-text-objects-swap-submod
      enable = true,
      swap_next = { ['<leader>>'] = '@swap.outer' },
      swap_previous = { ['<leader><'] = '@swap.outer' },
    },
    select = { -- nvim-treesitter-text-objects-select-submod
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@swap.outer',
        ['if'] = '@swap.inner',
      },
      include_surrounding_whitespace = true,
    },
    move = { -- nvim-treesitter-text-objects-move-submod  NOTE: nvim has default {[,]}{m,m} moves
      enable = true,
      set_jumps = true,
      goto_next_start = { [']]'] = '@swap.outer' },
      goto_previous_start = { ['[['] = '@swap.outer' },
    },
    lsp_interop = { -- nvim-treesitter-textobjects-lsp_interop-submod
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader><leader>d"] = "@function.outer",
      },
    },
  },
}
