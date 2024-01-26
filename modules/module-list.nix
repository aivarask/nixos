# map (n: "${./config}/${n}") (builtins.attrNames (builtins.readDir ./config)) ++
[
  ./system/boot/loader/efi.nix
  ./system/boot/loader/systemd-boot/systemd-boot.nix
  ./system/boot/networkd.nix
  ./system/boot/systemd.nix
  ./system/boot/tmp.nix
]
