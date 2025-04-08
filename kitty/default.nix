{ pkgs, config, ... }:
{
  programs.kitty = {
    enable = true;
  };
  xdg.configFile."kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/kitty/kitty.conf";
  # https://discourse.nixos.org/t/creating-symlinks-in-nixos/50280/3
  # xdg.terminal-exec.enable = true;
  # environment.variables.XDG_TERMINAL = "${pkgs.kitty}/bin/kitty";
  # environment.variables.XDG_SYSTEM_MONITOR = "${pkgs.resources}/bin/resources";
}
