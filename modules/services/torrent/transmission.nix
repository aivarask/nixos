_: {
  services.transmission = {
    enable = true;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };
}
