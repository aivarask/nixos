{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zig
    zls
    # zig-shell-completions
    # zap # https://github.com/zigzap/zap
  ];
}
