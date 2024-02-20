{ pkgs, lib, ... }: {
  environment.variables = {
    # https://stackoverflow.com/questions/13428910/how-to-set-the-environment-variable-ld-library-path-in-linux
    # LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.xorg.libX11 pkgs.zlib ];
  };
  # https://nixos.wiki/wiki/C
  environment.systemPackages = with pkgs; [
    ccls
    zlib
    zlib.dev
    # clang
    # clang-tools
    # gcc
    # libclang
    # libuv
    # gnome
    # glib
    # glibc
    # libglibutil
    # headers

  ] ++ (with xorg; [
    # xorgproto
    # libX11
    # libX11.dev
    # libXinerama
    # libXrender
  ]);
}




