{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    { plugin = nvim-ts-context-commentstring; type = "lua"; config = "require('ts_context_commentstring').setup({})"; }
    nvim-treesitter-textobjects
    nvim-ts-autotag
    nvim-treesitter-endwise
  ];
}
