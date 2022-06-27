{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = [
      pkgs.tmuxPlugins.resurrect
    ];
    extraConfig = ''
      unbind C-b
      set-option -g prefix M-`
      bind-key M-` send-prefix
    '';
  };
}


