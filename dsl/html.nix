{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    htmx-lsp
  ];
}
