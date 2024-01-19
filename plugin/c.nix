{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    libclang
    ccls
    clang
    clang-tools
    clang_13
    cmake-format
    cmake-language-server
    valgrind
  ];
}
