{ ... }:
{
  systemd.services.nix-daemon = {
    environment = {
      https_proxy = "socks5h://localhost:7891";
    };
  };
}
