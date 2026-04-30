{ pkgs, ... }:
{
  services.searx.enable = true;
  services.searx.redisCreateLocally = true;
  services.searx.settings.server = {
    bind_address = "::1";
      # port = yourPort;
      # WARNING: setting secret_key here might expose it to the nix cache
      # see below for the sops or environment file instructions to prevent this
      # secret_key = "Your secret key.";
    };
  }
