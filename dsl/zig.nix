{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zig
    zls
    # zig-shell-completions
  ];
}
