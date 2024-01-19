{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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
