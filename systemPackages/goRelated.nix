{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # https://nixos.wiki/wiki/Go
    go
    gopls
    go-task

    # flakes
    templ
    golines
    goimports-reviser
    gofumpt
    checkmake
    # debug
    delve
  ];
}
