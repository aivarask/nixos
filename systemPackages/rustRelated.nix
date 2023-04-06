{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    taplo
    taplo-cli
    taplo-lsp
    rust-analyzer
    rustc
    rustfmt
    rustup
    # rustup-toolchain-install-master
    cargo
    cargo-watch
    xh
  ];
}
