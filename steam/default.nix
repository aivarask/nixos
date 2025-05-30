{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steam-run
    steamcmd
    steam-tui
  ];
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
  programs.gamemode.enable = true;
}
