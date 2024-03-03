{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-autopairs
    cmp_luasnip
    luasnip
    friendly-snippets
    nvim-cmp
    cmp-nvim-lsp
    cmp-emoji
    cmp-path
    cmp-buffer
    cmp-cmdline
    # --
    cmp-zsh
    cmp-git
  ];
}
