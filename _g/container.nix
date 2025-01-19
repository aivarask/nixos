{ pkgs, config, ... }:
{
  imports = [
    ./httpd.nix
    ./php.nix
  ];
  # environment.profiles = [ "${./.}" ];
  environment.systemPackages = [ pkgs.websocketd ];
  services.httpd.virtualHosts."g.l" = import ./httpd_vh.nix "/etc/nixos/_g";
  containers.g = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
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
        networking.firewall.allowedTCPPorts = [
          22
          80
        ];
      };
  };
}
