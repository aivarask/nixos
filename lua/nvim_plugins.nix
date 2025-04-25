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
    telescope-fzf-native-nvim
    telescope-symbols-nvim
    telescope-manix
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
    misc
    # ++ testing
    ++ telescope
    ++ treesitter
    ++ next;
}
