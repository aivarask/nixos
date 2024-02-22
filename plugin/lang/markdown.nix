{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    marksman
    mdformat # hangs on man-cache
    markdownlint-cli
    markdownlint-cli2
  ];
}
