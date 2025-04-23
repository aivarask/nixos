{
  pkgs,
  lib,
  config,
  ...
}:
let
  vimOnlyPlugins = with pkgs.vimPlugins; [
    vim-indentwise
    vim-commentary
    vim-matchup
  ];
  neovimOnlyPlugins = with pkgs.vimPlugins; [
    vim-sensible
    nvim-nio
    auto-session
    which-key-nvim
    # nvim-surround
    indent-blankline-nvim
    lazygit-nvim
    # neogit
    gitsigns-nvim
    lualine-nvim
    nvim-tree-lua
    iron-nvim
    toggleterm-nvim
    # {
    #   plugin = sqlite-lua;
    #   config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
    # }
  ];
  common = with pkgs.vimPlugins; [
    sxhkd-vim
    vim-auto-save
    bclose-vim
    fzf-vim
    gruvbox-material
    switch-vim
    vim-abolish
    vim-cool
    vim-cursorword
    vim-devicons
    vim-highlightedyank
    vim-lastplace
    direnv-vim
    tabular
    vim-log-highlighting
    vim-interestingwords
  ];
in
{
  programs.vim.plugins = lib.mkIf (config.programs.vim.enable == true) (common ++ vimOnlyPlugins);
  programs.neovim.plugins = lib.mkIf (config.programs.neovim.enable == true) (
    common ++ neovimOnlyPlugins
  );
}
