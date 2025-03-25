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
    ];
    environment.sessionVariables = {
      C_INCLUDE_PATH = builtins.concatStringsSep ":" [
        "${pkgs.xorg.xorgproto}/include"

        # "${pkgs.zlib.dev}/include"
        # "${pkgs.libuv.dev}/include"
        # "${pkgs.check}/include"
      ];
      # CPLUS_INCLUDE_PATH = builtins.concatStringsSep ":" [
      #   "${pkgs.curl.dev}/include"
      #   "${pkgs.libcpr.dev}/include"
      #   "${pkgs.nlohmann_json}/include"
      # ];
    };
  }
]
