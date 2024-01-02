{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
