{ config, ... }:
let
  ssh = {
    services.openssh.enable = true;
    users.users.root.openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
  };
in
{
  containers.mini = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    config =
      { pkgs, ... }:
      ssh
      // {
        system.stateVersion = "25.05";
        networking.nat.enable = true;
        networking.nat.internalInterfaces = [ "ve-+" ];
        networking.nat.externalInterface =
          if config.networking.hostName == "dell" then "wlp59s0" else "wlp6s0";
        environment.systemPackages = with pkgs; [
          vim
          wget
        ];
      };
  };
}
