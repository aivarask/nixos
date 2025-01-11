# vim: fdl=4
{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkMerge [
  {
    boot.tmp.cleanOnBoot = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
    boot.loader.systemd-boot.enable = true;
    boot.kernel.sysctl = {
      "fs.inotify.max_user_watches" = 100001;
      "fs.inotify.max_queued_events" = 100001;
    };

    console = {
      font = "${pkgs.terminus_font}/share/consolefonts/ter-${
        if config.networking.hostName == "dell" then "v32n" else "v14n"
      }.psf.gz";
      useXkbConfig = true;
      # keyMap = lib.mkForce "us";
      # keyMap = "${pkgs.kbd}/share/keymaps/i386/qwerty/lt.map.gz";
    };

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];

    location = {
      # provider = lib.mkDefault "geoclue2"; # manual
      provider = lib.mkDefault "manual";
      latitude = 54.0;
      longitude = 25.0;
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = "kalesnykas.aivaras@gmail.com";
      defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };

    security.sudo.wheelNeedsPassword = false;
    security.pam.services.nginx.setEnvironment = false;

    time.timeZone = "Europe/Vilnius";
    users = {
      defaultUserShell = pkgs.zsh;
    };
    users.users."root" = {
      shell = pkgs.zsh;
      extraGroups = [ "http" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEs8Ir7meX21p/xxIfwz/Z9vYDF0VCE29t4pML7iF/X root@dell"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIANknZM5gmvqk6PlxOsiiPtmGEOH6HCIGs/YSarBXfEW root@pc"
      ];
    };
  }
]
