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
        networking.nat.enable = true;
        networking.nat.internalInterfaces = [ "ve-+" ];
        networking.nat.externalInterface =
          {
            dell = "wlp59s0";
            pc = "wlp6s0";
          }
          ."${config.networking.hostName}";
      }
      // (import ./ssh.nix config);
  };
}
