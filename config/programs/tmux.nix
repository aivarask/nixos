{ pkgs, ... }:
let
  stablePlugins = with pkgs.tmuxPlugins; [
    resurrect
    tmux-fzf
    tmux-floax

  ];
  disabled = with pkgs.tmuxPlugins; [
    tmux-fzf
    fzf-tmux-url
    tilish
    sensible # https://github.com/tmux-plugins/tmux-sensible

  ];
in
{
  # https://www.youtube.com/watch?v=GH3kpsbbERo
  environment.shellAliases.tmux = "tmux -f /etc/nixos/files/tmux.conf";
  environment.shellAliases.tmux_lf = "tmux split -h lf; lf";

  # /etc/tmux.conf
  programs.tmux = {
    enable = true;
    plugins = stablePlugins ++ [

    ];

    # terminal = "xterm-256color";
    # terminal = "tmux-direct";

    # keyMode = "vi";
    # extraConfig = ''
    #   unbind C-b
    #   set-option -g prefix M-`
    #   bind-key M-` send-prefix
    # '';
  };
}
