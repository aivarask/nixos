{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    libclang
    ccls
    clang
    clang-tools
    # cmake-format
    # cmake-language-server
    # universal-ctags
  ];
}
