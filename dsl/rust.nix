{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cargo
    cargo-nextest
    rustc
    rust-analyzer
    rustfmt
  ];
}
