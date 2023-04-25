{pkgs, ...}: {
  environment.systemPackages = with pkgs.haskellPackages; [
    # htoml
    # tomlcheck
    # htoml-megaparsec
  ];
}
