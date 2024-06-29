{ pkgs, ... }: {
  environment.shellAliases = {
    ecip = "echo $C_INCLUDE_PATH | tr ':' '\n'";
  };
  environment.variables = {
    C_INCLUDE_PATH = builtins.concatStringsSep ":" [
      "${pkgs.zlib.dev}/include"
      "${pkgs.libuv.dev}/include"
      "${pkgs.check}/include"
    ];
  };
  environment.systemPackages = with pkgs; [
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
    nlohmann_json
  ];
}
