{ config, pkgs, lib, ... }: {
  users.defaultUserShell = pkgs.zsh;
  users.users.root = {
    shell = pkgs.zsh;
    extraGroups = [ "http" ];
  };
  users.users.ak = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "pulse"
      "video"
      "disk"
      "networkmanager"
    ];
    shell = pkgs.zsh; # optional
  };
}
