{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];

  # https://wiki.nixos.org/wiki/Searching_packages

  environment.systemPackages = [
    pkgs.nps
  ];
  environment.variables.NIX_PACKAGE_SEARCH_EXPERIMENTAL = "true";
  environment.variables.NIX_PACKAGE_SEARCH_MULTILINE = "true";
  environment.variables.NIX_PACKAGE_SEARCH_COLOR_MODE = "auto";
  environment.variables.NIX_PACKAGE_SEARCH_EXACT_COLOR = "red";
  environment.variables.NIX_PACKAGE_SEARCH_DIRECT_COLOR = "green";
  environment.variables.NIX_PACKAGE_SEARCH_INDIRECT_COLOR = "blue";

  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-index.enableBashIntegration = true;
  # programs.nix-index-database.comma.enable = true;

}
