{ pkgs, ... }:
{
  home.sessionVariables = {
    # C_INCLUDE_PATH = builtins.concatStringsSep ":" [
    #   "${pkgs.zlib.dev}/include"
    #   "${pkgs.libuv.dev}/include"
    #   "${pkgs.check}/include"
    # ];
    # CPLUS_INCLUDE_PATH = builtins.concatStringsSep ":" [
    #   "${pkgs.curl.dev}/include"
    #   "${pkgs.libcpr.dev}/include"
    #   "${pkgs.nlohmann_json}/include"
    # ];
  };
  home.packages = with pkgs; [
    glibc
    glibcInfo
    clang
    clang-tools
    cmake
    # ccls
    glib # gio trash
    # check
    # meson
    # libcpr
    # nlohmann_json
  ];
}
