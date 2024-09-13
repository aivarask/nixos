{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zig
    zls
    zig-shell-completions
    zap
  ];
}
