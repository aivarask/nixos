# https://search.nixos.org/options?channel=24.05&from=0&size=50&sort=relevance&type=options&query=services.openssh
{ ... }: {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      X11Forwarding = true;
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
  # openssh.authorizedKeys
  # ../users.nix
}
