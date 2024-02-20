{
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/add-custom-cache-servers#accelerate-package-downloads-via-a-proxy-server
  systemd.services.nix-daemon.environment = {
    # socks5h means that the hostname is resolved by the SOCKS server
    https_proxy = "socks5h://localhost:7891";
    # https_proxy = "http://localhost:7890"; # or use http protocol instead of socks5
  };
}
