{ lib, pkgs, ... }:
lib.mkMerge [
  {
    # c
    environment.systemPackages = with pkgs; [
      glibc
      # glibcInfo
      clang
      clang-tools
      cmake
      # ccls
      # check
      # meson
      # libcpr
      # nlohmann_json
      vscode-langservers-extracted
    ];
    environment.pathsToLink = [ "/include" ];
    environment.extraOutputsToInstall = [
      # "dev"
      # "info"
    ];
    environment.sessionVariables.CPATH = [
      "/etc/nixos/include"
      "/root/include"
      "${pkgs.xorg.libXrender.dev}/include"
      "${pkgs.xorg.libX11.dev}/include"
      "${pkgs.xorg.xorgproto}/include"
      "${pkgs.xorg.libXft.dev}/include"
      "${pkgs.freetype.dev}/include"
      "${pkgs.fontconfig.dev}/include"
    ];

    environment.sessionVariables = {
      # CPATH = "";
      # C_INCLUDE_PATH = builtins.concatStringsSep ":" [
      # "${pkgs.xorg.xorgproto}"

      # "${pkgs.zlib.dev}/include"
      # "${pkgs.libuv.dev}/include"
      # "${pkgs.check}/include"
      # ];
      # CPLUS_INCLUDE_PATH = builtins.concatStringsSep ":" [
      #   "${pkgs.curl.dev}/include"
      #   "${pkgs.libcpr.dev}/include"
      #   "${pkgs.nlohmann_json}/include"
      # ];
    };
  }
]
