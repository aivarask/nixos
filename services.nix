{ pkgs, lib, ... }:
{
  services.udisks2.enable = true;
  services.udisks2.settings = { };
  services.udisks2.mountOnMedia = true;
  programs.gnome-disks.enable = true;
  services.espanso.enable = true;
  services.espanso.package = pkgs.espanso-wayland;
  services.playerctld.enable = true;

  services.logind.settings.Login.HandlePowerKey = "ignore";

  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.KeepAlive = "yes";
  services.maddy.ensureCredentials."test@localhost".passwordFile =
    "${pkgs.writeText "postmaster" "l"}";

  services.maddy.enable = true;
  services.maddy.primaryDomain = "localhost";
  services.maddy.ensureAccounts = [
    "test@localhost"
  ];

  services.nginx.defaultHTTPListenPort = 80;
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
