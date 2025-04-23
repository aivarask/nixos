{ pkgs, config, ... }:
{
  xdg.configFile."vim/vimrc".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lua/vimrc";
  programs.vim = {
    enable = true;
    extraConfig = ''source $XDG_CONFIG_HOME/vim/vimrc'';
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-which-key
      vim-surround
      auto-pairs
      nerdtree
    ];
  };
}
