{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ ];
  environment.variables.HTOPRC = "/etc/nixos/config/files/htoprc";
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };

  programs.zsh.enable = true;
  programs.mtr.enable = true;
  programs.bandwhich.enable = false;
  programs.browserpass.enable = false;
  programs.iftop.enable = true;
  programs.npm.enable = true;
  programs.screen = {
    enable = true;
    screenrc = '''';
  };
  programs.sharing.enable = true;
  programs.wireshark.enable = true;

  environment.shellAliases.tmux = "tmux -f /etc/nixos/config/files/tmux.conf";
  environment.shellAliases.tmux_lf = "tmux split -h lf; lf";
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      tmux-fzf
      tmux-floax

      # tmux-fzf
      # fzf-tmux-url
      # tilish
      # sensible # https://github.com/tmux-plugins/tmux-sensible
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
