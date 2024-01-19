{ lib, ... }: {
  services.xserver.displayManager.sddm.enable = lib.mkDefault false;
}
