{ config, ... }:
{
  containers.aldale = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.200.10";
    localAddress = "192.168.200.11";
    config =
      { pkgs, ... }:
      {
        imports = [ ];
        system.stateVersion = "25.05";
        environment.systemPackages = with pkgs; [
          vim
          wget
        ];
      }
      // (import ./ssh.nix config)
      // (import ./nat.nix config);
  };
}
