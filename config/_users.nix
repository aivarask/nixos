{ pkgs, ... }: {
  users = {
    defaultUserShell = pkgs.zsh;
  };
  users.users.root = {
    shell = pkgs.zsh;
    extraGroups = [ "http" "adbusers" ];
  };
  users.users.ak = {
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "wheel"
      "audio"
      "pulse"
      "video"
      "disk"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };
}
