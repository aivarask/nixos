{ ... }: {
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };
  # openssh.authorizedKeys
  # ../users.nix
}
