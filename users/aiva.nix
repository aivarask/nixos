{ ... }:
{
  users.users.aiva = {
    isNormalUser = true;
    home = "/home/aiva";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
