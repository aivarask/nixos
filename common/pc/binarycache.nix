{ config, ... }:
let
  ip =
    {
      pc = "http://192.168.1.180";
      dell = "http://192.168.1.190";
    }
    .${config.networking.hostName};
in
{
  # /etc/nix/machines
  nix.buildMachines = [
    # {
    #   hostName = "192.168.1.180";
    #   system = "x86_64-linux";
    #   protocol = "ssh-ng";
    #   maxJobs = 3;
    #   speedFactor = 2;
    #   supportedFeatures = [
    #     "nixos-test"
    #     "benchmark"
    #     "big-parallel"
    #     "kvm"
    #   ];
    #   mandatoryFeatures = [ ];
    # }
  ];
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };
  networking.firewall.allowedTCPPorts = [
    80
  ];
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "${ip}" = {
        locations."/".proxyPass =
          "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      };
    };
  };
}
