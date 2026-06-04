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
  programs.steam.package = pkgs.steam.override {
    extraPkgs =
      pkgs': with pkgs'; [
        libXcursor
        libXi
        libXinerama
        libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib # Provides libstdc++.so.6
        libkrb5
        keyutils
        # Add other libraries as needed
      ];
  };

  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };
  environment.systemPackages = with pkgs; [
    steamcmd
    steam-run
    gamescope-wsi # HDR won't work without this
    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
  ];
}
