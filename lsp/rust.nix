{ pkgs, ... }: {
  environment.variables = {
    LD_LIBRARY_PATH = "${pkgs.lldb.lib}/lib/liblldb.so";
  };
  environment.systemPackages = with pkgs; [
    cargo
    cargo-nextest
    rustc
    rust-bin.stable.latest.default # from overlay
    rust-analyzer
    rustfmt
  ];
}
