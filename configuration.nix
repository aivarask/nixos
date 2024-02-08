{ include, ... }:
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
}
