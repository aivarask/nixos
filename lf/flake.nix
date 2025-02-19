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
              source /etc/nixos/lf/lfrc
            '';
          };
        };
    };
}
