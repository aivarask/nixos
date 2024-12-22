# vim: nofoldenable
# https://nixos.org/manual/nixos/unstable/#ch-containers
{ config, ... }:
let
  keys = config.users.users.root.openssh.authorizedKeys.keys;
  ssh = {
    services.openssh.enable = true;
    users.users.root.openssh.authorizedKeys.keys = keys;
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
      {
        system.stateVersion = "25.05";
        services.openssh.enable = true;
        users.users.root.openssh.authorizedKeys.keys = keys;
        networking.nat.enable = true;
        networking.nat.internalInterfaces = [ "ve-+" ];
        networking.nat.externalInterface = "eth0";
        #
        environment.systemPackages = with pkgs; [ vim ];

      };
  };
  containers.midi = {
    autoStart = true;
    config =
      { ... }:
      ssh
      // {
        system.stateVersion = "25.05";

      }
      // { };

  };
}
