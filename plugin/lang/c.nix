{ pkgs, lib, ... }: {
  environment.variables = {
    # https://stackoverflow.com/questions/13428910/how-to-set-the-environment-variable-ld-library-path-in-linux
    LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.xorg.libX11 pkgs.zlib ];
  };
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
    # headers
    libxml2
    libxml2.dev
    libcs50
    zlib

  ] ++ (with xorg; [
    xorgproto
    libX11
    libX11.dev
    # libXinerama
    # libXrender
  ]);
}




