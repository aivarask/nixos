{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    taplo
    taplo-cli
    taplo-lsp
  ];
}
