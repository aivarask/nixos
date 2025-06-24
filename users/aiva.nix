{
  hm =
    {
      config,
      SELF,
      lib,
      ...
    }:
    {
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
