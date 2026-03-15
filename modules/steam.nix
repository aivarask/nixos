{ pkgs, ... }:
{
  users.users."steam".enable = true;
  users.users."steam".isNormalUser = true;
  hardware.graphics.enable32Bit = true;
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
}
