{ pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.zsh;
  };
  users.users."root" = {
    shell = pkgs.zsh;
    extraGroups = [ "http" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEs8Ir7meX21p/xxIfwz/Z9vYDF0VCE29t4pML7iF/X root@dell"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANknZM5gmvqk6PlxOsiiPtmGEOH6HCIGs/YSarBXfEW root@pc"
    ];
  };
  users.users.ak = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "pulse"
      "video"
      "disk"
      "networkmanager"
    ];
  };
}
