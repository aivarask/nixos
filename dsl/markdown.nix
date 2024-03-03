{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    marksman
    mdformat
    markdownlint-cli
    markdownlint-cli2
  ];
}
