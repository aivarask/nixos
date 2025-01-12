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
        networking.firewall.allowedTCPPorts = [ 80 ];
        services.httpd.enable = true;
        services.httpd.adminAddr = "mini@example.org";
        # services.httpd.virtualHosts.localhost.documentRoot = "/webroot";
        services.httpd.virtualHosts.localhost.documentRoot = ./.;
      };
  };
}
