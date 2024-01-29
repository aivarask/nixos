{ pkgs, ... }: {
  programs.mtr.enable = true;
  programs.adb.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.zsh.enable = true;
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

  programs.hyprland = {
    enable = false;
    xwayland.enable = false;
  };
}
