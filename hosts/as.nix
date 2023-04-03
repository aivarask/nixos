{ ... }: {
  imports = [
    ./_networking.nix
    ./as-hardware.nix
  ];
  system.stateVersion = "23.05";

  networking = {
    hostName = "as";
    hostId = "8425e349";
    useDHCP = false;
    interfaces.enp2s0f2.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
  };

  services.xserver = {
    videoDrivers = [ "modesetting" ];
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
  services.blueman.enable = false;
}
