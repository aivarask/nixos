{ pkgs, ... }:
{
  home.shellAliases = {
    ecip = "echo $C_INCLUDE_PATH | tr ':' '\n'";
  };
  home.sessionVariables = {
    C_INCLUDE_PATH = builtins.concatStringsSep ":" [
      "${pkgs.zlib.dev}/include"
      "${pkgs.libuv.dev}/include"
      "${pkgs.check}/include"
    ];
    CPLUS_INCLUDE_PATH = builtins.concatStringsSep ":" [
      "${pkgs.curl.dev}/include"
      "${pkgs.libcpr.dev}/include"
      "${pkgs.nlohmann_json}/include"
    ];
  };
  home.packages = with pkgs; [
    clang
    (clang-tools.override {
      enableLibcxx = false;
    })
    gcc
    ccls
    glib # gio trash
    check
    cmake
    meson
    libcpr
    nlohmann_json
  ];
}
