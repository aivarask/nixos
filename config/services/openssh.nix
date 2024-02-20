{ ... }: {
  # networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    openFirewall = true;
  };
  # openssh.authorizedKeys
  # ../users.nix
}
