# REL:
# modules/services/desktops/geoclue2.nix
# /etc/nixos/modules/config/location.nix
{...}: {
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500; # 5500
      night = 4500; # 3700
    };
  };
}
