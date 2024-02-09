{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    symbols-outline-nvim
    flatten-nvim
    glow-nvim
    { plugin = dressing-nvim; type = "lua"; config = "require('dressing').setup({})"; }
    { plugin = neoscroll-nvim; type = "lua"; config = "require('neoscroll').setup({})"; }
    { plugin = nvim-colorizer-lua; type = "lua"; config = "require('colorizer').setup({})"; }
    { plugin = nvim-web-devicons; type = "lua"; config = "require('nvim-web-devicons').setup({})"; }
  ];
}
