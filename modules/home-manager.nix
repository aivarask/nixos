{
  inputs,
  ...
}:
let
  SELF = "/etc/nixos";
  xdgconf = "${SELF}/.config";
in
{
  home-manager = {
    startAsUserService = false;
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    extraSpecialArgs = { inherit inputs SELF xdgconf; };
    sharedModules = [
      {
        home.stateVersion = "26.05";
        home.enableNixpkgsReleaseCheck = false;
      }
      inputs.nix-colors.homeManagerModules.default
    ];
    users.root.home.username = "root";
    users.root.home.homeDirectory = "/root";
  };
}
