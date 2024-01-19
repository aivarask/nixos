{ config
, lib
, pkgs
, ...
}: {
  services.sshd.enable = true;
  services.nginx.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 ];

  users.users.root.password = "l";
  services.openssh.settings.PermitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";
  environment.systemPackages = with pkgs; [
    git
    vim
    lazygit
    lf
  ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
