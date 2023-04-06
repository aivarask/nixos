{ ... }: {
  imports = [
    ./_common.nix
    ./as-hardware.nix
  ];
  system.stateVersion = "23.05";
  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
  };

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
      touchpad.naturalScrolling = true;
    };
  };
}
