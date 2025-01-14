# vim: nofoldenable
{ config, ... }:
let
  ssh = {
    services.openssh.enable = true;
    users.users.root.openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
  };
in
{
  containers.aldale = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.200.10";
    localAddress = "192.168.200.11";
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
        services.httpd.virtualHosts."localhost" = rec {
          # forceSSL = true;
          # addSSL = true;
          # sslServerKey = "/etc/nixos/a/cert.key";
          # sslServerCert = "/etc/nixos/a/cert.pem";
          # serverAliases = [ "a.local" ];
          documentRoot = ./.;
          extraConfig = ''
            <Directory "${documentRoot}">
            	Options FollowSymlinks
            	AllowOverride All
            </Directory>
          '';
        };
      };
  };
}
