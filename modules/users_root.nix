{ lib, ... }: {
  imports = [
    (lib.mkAliasOptionModule [ "root" ] [ "home-manager" "users" "root" ])
  ];
  users.users."root".linger = true;
  users.users."root".extraGroups = [
    "audio"
    "pipewire"
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
