{ ... }: {
  # networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings.PermitRootLogin = "yes";
    settings = {
      # https://unix.stackexchange.com/questions/12755/how-to-forward-x-over-ssh-to-run-graphics-applications-remotely
      X11Forwarding = true;
    };
  };
  # openssh.authorizedKeys
  # ../users.nix
}
