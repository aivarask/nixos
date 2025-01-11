# vim: nofoldenable
{
  outputs =
    { ... }:
    {
      nixosModules.default =
        { ... }:
        {
          environment.profiles = [ "${./.}" ];
        };
      nixosModules.home =
        { ... }:
        {
          xdg.configFile."lf/icons".source = ./icons;
          programs.lf = {
            enable = true;
            extraConfig = ''
              					# source ${./lfrc}
              					source /etc/nixos/lf/lfrc
            '';
          };
        };
    };
}
