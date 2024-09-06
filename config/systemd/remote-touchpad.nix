{ pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 9000 ];
  systemd.services.remote-touchpad = {
    enable = true;
    documentation = "https://github.com/unrud/remote-touchpad";
    after = [ "network.target" ];
    environment = {
      XDG_SESSION_TYPE = "x11";
    };
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      User = "root";
      Group = "wheel";
      WorkingDirectory = "~";
      ExecStart = "${pkgs.remote-touchpad}/bin/remote-touchpad -bind :9000 -secret pc";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

