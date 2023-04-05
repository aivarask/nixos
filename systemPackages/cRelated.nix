{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ccls
    clang
    clang-tools
    clang_13
    cmake-format
    cmake-language-server
    valgrind
  ];
}
