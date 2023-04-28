_: {
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    3000
    3306
    4173
    5173
    5434
    9000
    9100
  ];
}
