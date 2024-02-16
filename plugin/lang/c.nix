{ pkgs, ... }: {
  # https://nixos.wiki/wiki/C
  environment.systemPackages = with pkgs; [
    gcc
    libclang
    ccls
    clang
    clang-tools
    glibc
    libuv
    glib
    libglibutil
  ];
}
