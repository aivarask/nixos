{ ... }:
{
  # https://www.xmodulo.com/how-to-speed-up-x11-forwarding-in-ssh.html
  # https://mynixos.com/nixpkgs/option/services.openssh.settings.Ciphers

  programs.ssh = {
    # ciphers = [ ];
    forwardX11 = true;
    # compression = true; # home-manager
  };
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      # Ciphers = [ ];
      X11Forwarding = true;
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
}
