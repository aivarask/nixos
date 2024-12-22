{ pkgs, inputs, ... }:
{
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
  programs.hyprland = {
    # https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
