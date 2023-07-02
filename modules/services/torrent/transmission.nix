_: {
  services.transmission = {
    enable = false;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };
}
