{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # https://nixos.wiki/wiki/Go
    go
    go-task
  ];
}
