{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [ neotest neotest-plenary ];
}
