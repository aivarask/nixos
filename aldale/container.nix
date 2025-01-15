{ config, ... }:
{
  imports = [ ./httpd.nix ];
  services.httpd.virtualHosts."aldale.local" = import ./httpd_vh.nix "/etc/nixos/aldale";
  containers.aldale = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.200.10";
    localAddress = "192.168.200.11";
    config =
      { pkgs, ... }:
      (import ./ssh.nix config)
      // (import ./nat.nix config)
      // {
        system.stateVersion = "25.05";
        environment.systemPackages = with pkgs; [
          nmap
          vim
          wget
          lf
        ];
        imports = [
          ./php.nix
          ./httpd.nix
        ];
        services.httpd.virtualHosts."localhost" = import ./httpd_vh.nix "${./.}";
        networking.firewall.allowedTCPPorts = [ 80 ];
      };
  };
}
