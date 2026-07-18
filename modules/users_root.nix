{ lib, ... }: {
  imports = [
    (lib.mkAliasOptionModule [ "root" ] [ "home-manager" "users" "root" ])
  ];
  home-manager.users.root = {
    home.username = "root";
    home.homeDirectory = "/root";
        home.extraOutputsToInstall =  
        # osConfig.environment.
        [
          "info"
          "doc"
        ];
  };
}
