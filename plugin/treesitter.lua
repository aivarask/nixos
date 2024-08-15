if not pcall(require, 'nvim-treesitter') then return end
vim.cmd [[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  set nofoldenable
]]

require 'treesitter-context'.setup { enable = true, }                              --- @see nvim-treesitter-context
vim.g.skip_ts_context_commentstring_module = true
require 'ts_context_commentstring'.setup {}                                        --- @see ts-context-commentstring
require 'nvim-ts-autotag'.setup { filetypes = { "html", 'php', 'twig', 'xml', }, } --- @see https://github.com/windwp/nvim-ts-autotag/
require 'nvim-treesitter.configs'.setup {                                          --- @see nvim-treesitter
  highlight = { enable = true, },                                                  --- @see nvim-treesitter-highlight-mod
  incremental_selection = {                                                        --- @see nvim-treesitter-incremental-selection-mod
    enable = true,
    keymaps = {
      init_selection = "tt",
      node_incremental = "<tab>",
      scope_incremental = "ti",
      node_decremental = "<s-tab>",
    },
  },
  indent = { enable = true, },  --- @see nvim-treesitter-indentation-mod
  matchup = { enable = true, }, --- @see vim-matchup
  endwise = { enable = true, }, --- @see https://github.com/RRethy/nvim-treesitter-endwise/
  textobjects = {               --- @see nvim-treesitter-textobjects
    swap = {                    --- @see nvim-treesitter-text-objects-swap-submod
      enable = true,
      swap_next = { ['<leader>>'] = '@swap.outer', },
      swap_previous = { ['<leader><'] = '@swap.outer', },
    },
    select = { --- @see nvim-treesitter-text-objects-select-submod
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@swap.outer',
        ['if'] = '@swap.inner',
        ['tt'] = '@table.inner',
        ['sb'] = '@block.inner',
      },
      include_surrounding_whitespace = true,
    },
    move = { --- @see nvim-treesitter-text-objects-move-submod  NOTE: nvim has default {[,]}{m,m} moves
      enable = true,
      set_jumps = true,
      goto_next_start = { [']]'] = '@swap.outer', },
      goto_previous_start = { ['[['] = '@swap.outer', },
    },
    lsp_interop = { --- @see nvim-treesitter-textobjects-lsp_interop-submod
      enable = true,
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader><leader>d"] = "@function.outer",
      },
    },
  },
}
