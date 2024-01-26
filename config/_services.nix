{ lib, config, pkgs, ... }: {
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    hwRender = lib.mkDefault true;
    extraConfig = lib.mkDefault ''
      font-size=12
      font-dpi=72
    '';
    fonts = lib.mkDefault [
      {
        name = "Hack Nerd Font Mono";
        package = pkgs.hack-font;
      }
    ];
  };
  # https://nixos.wiki/wiki/Binary_Cache
  # https://github.com/NixOS/nix/issues/1990
  # nixos-rebuild switch --fallback --show-trace --option binary-caches https://cache.nixos.org/
  # ../web-servers/nginx/default.nix
  # ../web-servers/caddy/default.nix
  services.nix-serve = {
    enable = false;
    secretKeyFile = "/var/cache-priv-key.pem";
    # port = 5000; # default 5000
  };
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
  };
  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiko5+WigWfHzZsniVYM184iC4JoZ0MZl+KbZIajY914/IPPLR00mKX+Aaxkjci6nMTUym9UjITtnCDO5lDTOI8Qyb1oDCUGUxVdgryRpGtEcV6Wg8kgRVDEIeAdKTy8LVWW6ZC25bJiOP/WMBppQcaL74MgxDrMQtw8BBo8xDObZxnnFz7gizg8Lbkruf2IkReKj174Pu6zFeHcbPLI8bR/noFqIe0Vk2UDV5g5f9lonsdtlV3DCvbOX9aopWtX1f5ueiCPuAT+00UB5jgC7+bmXzlayGDGNL3k6Qeqs3gmSObGQXcWwNO4CblnkR2ITzKUY2p2nZrFfJE1PHr4KzCzSRJpZi8/iz3i0+8se8vVb28GF3T2FGwwzXAHjp6QwNo2orqWeIo+Dzz4slnzkeMaIPBvkqstIP2v7vUTUMuTuQN+Ouu6y3p2IZfCFDWlTB/Wlf+JEVT4F1FA45RmFGm9ud09okrnt1fkwnr59zk2N8JiIQcGn6lCuzDjHobgM= root"
  ];
  services.geoclue2 = {
    enable = lib.mkIf true true;
  };
  services.blueman = {
    # Device B8:53:AC:C2:7F:24 Aivaras’s iPhone
    # Device AC:90:85:C6:DA:FD AirPods
    # Device D4:11:A3:98:B4:88 Galaxy A50
    enable = lib.mkDefault false;
  };
  services.mpd = {
    enable = true;
    user = "root";
    group = "wheel";
    playlistDirectory = /etc/nixos/playlist;
    # network.listenAddress = "any";
    startWhenNeeded = true;
    extraConfig = ''
      auto_update "yes"
      music_directory "/var/music"
      audio_output {
        type "pulse"
        name "Pulseaudio"
        server "0.0.0.0"
      }
      playlist_plugin {
        name "m3u"
        enabled "true"
      }
      # bind_to_address "0.0.0.0:6600"
      # bind_to_address "/var/lib/mpd/socket"
      bind_to_address "/run/mpd/socket"
    '';
  };
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  services.transmission = {
    enable = true;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    # settings = {
    #   ipv6_servers = true;
    #   require_dnssec = true;

    #   sources.public-resolvers = {
    #     urls = [
    #       "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
    #       "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
    #     ];
    #     cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
    #     minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
    #   };
    # };
    # serviceConfig = {
    #   StateDirectory = "dnscrypt-proxy";
    # };

  };
}
