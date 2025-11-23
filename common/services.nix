{ pkgs, lib, ... }:
{
  imports = [

  ];
  # https://www.xmodulo.com/how-to-speed-up-x11-forwarding-in-ssh.html
  # https://mynixos.com/nixpkgs/option/services.openssh.settings.Ciphers

  programs.ssh = {
    # ciphers = [ ];
    # forwardX11 = true;
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
      KeepAlive = "yes";
    };
  };
  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
    ];
    ensureCredentials = {
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
    };
  };
  environment.systemPackages = with pkgs; [
    bitmagnet
    magnetico
    tremc
  ];
  services.transmission = {
    enable = true;
    package = pkgs.transmission_4;
    openPeerPorts = true;
    settings = {
      watch-dir = "/var/lib/transmission/watchdir";
      watch-dir-enabled = true;
    };
  };
  services.nginx.defaultHTTPListenPort = 8080;
  services.nginx = {
    # enable = false;
    # recommendedProxySettings = true;
    # recommendedOptimisation = true;
    # recommendedTlsSettings = true;
    # recommendedGzipSettings = true;
    # recommendedZstdSettings = true;
    # recommendedBrotliSettings = true;
    # defaultHTTPListenPort = 8080;
  };
  systemd.services.nginx.serviceConfig = {
    SupplementaryGroups = [ "shadow" ];
    NoNewPrivileges = lib.mkForce false;
    PrivateDevices = lib.mkForce false;
    ProtectHostname = lib.mkForce false;
    ProtectKernelTunables = lib.mkForce false;
    ProtectKernelModules = lib.mkForce false;
    RestrictAddressFamilies = lib.mkForce [ ];
    LockPersonality = lib.mkForce false;
    MemoryDenyWriteExecute = lib.mkForce false;
    RestrictRealtime = lib.mkForce false;
    RestrictSUIDSGID = lib.mkForce false;
    SystemCallArchitectures = lib.mkForce "";
    ProtectClock = lib.mkForce false;
    ProtectKernelLogs = lib.mkForce false;
    RestrictNamespaces = lib.mkForce false;
    SystemCallFilter = lib.mkForce "";
  };
}
