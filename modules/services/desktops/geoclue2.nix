{lib, ...}: {
  services.geoclue2 = {
    enable = false;
    # appConfig.redshift.isAllowed = true;
  };
}
