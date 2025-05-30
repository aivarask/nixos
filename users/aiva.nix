{ ... }:
{
  users.users.aiva = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/aiva";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
