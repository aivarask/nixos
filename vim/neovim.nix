{ pkgs, ... }:
let
  dap = with pkgs.vimPlugins; [
    nvim-dap
    nvim-dap-virtual-text
    telescope-dap-nvim
    nvim-dap-ui
    # nvim-dap-go
    # nvim-dap-python
  ];
  lsp = with pkgs.vimPlugins; [
    conform-nvim
    nvim-lspconfig
    none-ls-nvim
    goto-preview
    lsp-overloads-nvim
    lspkind-nvim
    nvim-genghis
  ];
  misc = with pkgs.vimPlugins; [
    SchemaStore-nvim
    outline-nvim
    flatten-nvim
    glow-nvim
    nvim-colorizer-lua
    nvim-web-devicons
    image-nvim
  ];
  telescope = with pkgs.vimPlugins; [
    telescope-nvim
    # telescope-fzf-native-nvim
    telescope-symbols-nvim
    # trouble-nvim
    # todo-comments-nvim
  ];
  testing = with pkgs.vimPlugins; [
    # vim-test
    neotest
    neotest-bash
    neotest-go
    neotest-jest
    neotest-phpunit
    neotest-pest
    # neotest-plenary
    neotest-python
    neotest-rust
    neotest-zig
    neotest-vitest
  ];
  treesitter = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    nvim-treesitter-endwise
    nvim-treesitter-context
    nvim-ts-autotag
    nvim-ts-context-commentstring
    nvim-treesitter-textobjects
    nvim-treesitter-textsubjects
  ];
  next = with pkgs.vimPlugins; [
    nui-nvim
    nvim-notify
    plenary-nvim
    fidget-nvim
  ];
in
{

  programs.neovim.plugins =
    # ++ dap
    # ++ lsp
    misc
    # ++ testing
    ++ telescope
    ++ treesitter
    ++ next;
}
