_: {
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    22 # ssh
    80 # http
    443 # https
    # 3000 # serve
    # 3001 modules/system/boot/services/serve-music.nix
    3306 # mysql
    4173 # vite preview
    5173 # vite dev
    6173 # vite e2e
    5434 # postgresql
    6600 # mpd
    9000 # remote-touchpad
    9100
  ];
}
