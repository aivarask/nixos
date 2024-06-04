{ ... }: {
  services.libinput = {
    mouse = { accelSpeed = "+0.5"; };
    touchpad = { naturalScrolling = true; accelSpeed = "+0.5"; };
  };
}
