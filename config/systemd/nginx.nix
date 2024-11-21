{ pkgs, lib, ... }:
let
  phpCustom = pkgs.php.buildEnv {
    extensions = (
      { enabled, all }:
      enabled
      ++ (with all; [
        xdebug
      ])
    );
    extraConfig = ''
      xdebug.idekey=nvim
      xdebug.mode=debug
      xdebug.start_with_request=yes
      upload_max_filesize=30M
      post_max_size=31M
      memory_limit = 100M
      max_execution_time = 120
    '';
    # zend_extension=${pkgs.phpExtensions.xdebug.outPath}/lib/php/extensions/xdebug.so
  };
in
{
  environment.systemPackages = [ phpCustom ];
  networking.firewall.allowedTCPPorts = [
    80
    12345
  ];
  services.httpd = {
    enable = true;
    enablePHP = true;
    # user = "root";
    group = "root";
  };
  services.httpd.phpPackage = phpCustom;
  services.httpd.extraModules = [
    "proxy_wstunnel"
  ];
  services.httpd.virtualHosts = {
    # https://mynixos.com/nixpkgs/options/services.httpd.virtualHosts.%3Cname%3E
    "a.local" = rec {
      # forceSSL = true;
      # addSSL = true;
      serverAliases = [ ];
      documentRoot = "/etc/nixos/a";
      extraConfig = ''
        ProxyPass "/ws2/"  "ws://a.local:12345/websockets.php"
        <Directory "${documentRoot}">
        	Options FollowSymlinks
        	AllowOverride All
        	# Require all granted
        </Directory>
      '';
    };
  };
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;
    # recommendedGzipSettings = true;
    # recommendedZstdSettings = true;
    # recommendedBrotliSettings = true;
    defaultHTTPListenPort = 8080;
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
