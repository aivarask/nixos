{pkgs, ...}: {
# https://www.youtube.com/watch?v=GH3kpsbbERo
  programs.tmux = {
    enable = true;
    plugins = [
      pkgs.tmuxPlugins.resurrect
    ];
    terminal = "xterm-256color";
    keyMode = "vi";
    extraConfig = ''
      unbind C-b
      set-option -g prefix M-`
      bind-key M-` send-prefix
    '';
  };
}
