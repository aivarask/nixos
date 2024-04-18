{ include, ... }:
{
  imports = [
    # ./paging.nix
  ]
  ++ include ./config
  ++ include ./config/environment
  ++ include ./config/programs
  ++ include ./config/services
  ++ include ./config/suckless
  ++ include ./config/systemd
  ++ include ./dsl
  ++ include ./sql
  ;
  environment.variables = { };

  environment.shellAliases = { };

  # environment.systemPackages
}
