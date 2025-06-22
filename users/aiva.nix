{
  hm =
    { config, SELF, ... }:
    {
      home.file.".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/users/xinitrc";
    };
  system =
    { ... }:
    {
      users.users.aiva = {
        uid = 1000;
        isNormalUser = true;
        home = "/home/aiva";
        extraGroups = [
          "root"
          "wheel"
          "tty"
          "networkmanager"
          "audio"
          "video"
          "pipewire"
        ];
      };
    };
}
