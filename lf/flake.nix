{
  outputs =
    { ... }:
    {
      nixosModules = {
        default =
          { ... }:
          {
            # environment.profiles = [ "${./.}" ];
            environment.sessionVariables.PATH = [ "/etc/nixos/lf/bin" ];

          };
        yazi.home = {
          # https://github.com/sxyazi/yazi

        };
        home =
          { ... }:
          {
            xdg.configFile."lf/icons".source = ./icons;
            # https://github.com/gokcehan/lf
            programs.lf = {
              enable = true;
              extraConfig = ''
                source /etc/nixos/lf/lfrc
              '';
            };
          };

      };
    };
}
