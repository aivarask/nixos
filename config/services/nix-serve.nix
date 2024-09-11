{ ... }:
{
  # https://nixos.wiki/wiki/Binary_Cache
  # https://github.com/NixOS/nix/issues/1990
  # nixos-rebuild switch --fallback --show-trace --option binary-caches https://cache.nixos.org/
  services.nix-serve = {
    enable = false;
    secretKeyFile = "/var/cache-priv-key.pem";
    # port = 5000; # default 5000
  };
}
