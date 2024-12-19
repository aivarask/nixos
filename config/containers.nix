# vim: nofoldenable
{ config, pkgs, ... }:
{
  containers.database = {
    config =
      { config, pkgs, ... }:
      {
        services.openssh.enable = true;
        # services.postgresql.enable = true;
        # services.postgresql.package = pkgs.postgresql_14;
      };
  };
}
