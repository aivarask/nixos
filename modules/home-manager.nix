{
  inputs,
  SELF,
  xdgconf,
  ...
}:
{
  home-manager.extraSpecialArgs = { inherit inputs SELF xdgconf; };
  home-manager.startAsUserService = false;
  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.sharedModules = [
    inputs.nix-colors.homeManagerModules.default
    {
      home.stateVersion = "26.05";
      home.enableNixpkgsReleaseCheck = false;
    }
  ];
}
