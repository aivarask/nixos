{pkgs, ...}: {
  environment.systemPackages = [pkgs.statix pkgs.alejandra];
}
