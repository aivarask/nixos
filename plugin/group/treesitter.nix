{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    nvim-treesitter-endwise
    nvim-ts-autotag
    nvim-treesitter-context
    nvim-ts-context-commentstring
    nvim-treesitter-textobjects
  ];
}
