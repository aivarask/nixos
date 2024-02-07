{ pkgs, include, ... }:
{
  imports = [
    # ./paging.nix
  ]
  ++ include ./config
  ++ include ./config/environment
  ++ include ./config/programs
  ++ include ./config/services
  ++ include ./config/systemd
  ++ include ./plugin
  ;
  environment.variables = {
    #
  };

  environment.shellAliases = {
    tilda = "tilda -g /etc/nixos/tilda";
  };

  # https://nixos.org/manual/nixpkgs/unstable/#vim
  environment.systemPackages = with pkgs; [
    # https://nixos.org/manual/nixpkgs/unstable/#vim
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/applications/editors/vim/plugins/vim-utils.nix
    vim-full
  ];
}
