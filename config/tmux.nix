{pkgs, ...}: {
  # https://tmuxcheatsheet.com/
  # https://wiki.archlinux.org/title/Tmux
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
