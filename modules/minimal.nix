# https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
# wireless https://nixos.org/manual/nixos/stable/index.html#sec-building-image-drivers
# build nix build .\#nixosConfigurations.exampleIso.config.system.build.isoImage
# test https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Testing_the_image
# emulate qemu-system-x86_64 -enable-kvm -m 256 -cdrom result/iso/nixos-*.iso
#     https://wiki.nixos.org/wiki/QEMU
#     https://wiki.gentoo.org/wiki/QEMU/Bridge_with_Wifi_Routing
# build nix build .\#nixosConfigurations.exampleIso.config.system.build.isoImage &&
# partition
# UEFI(GPT) https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-UEFI
# format https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning-formatting
# install https://nixos.org/manual/nixos/stable/#sec-installation-manual-installing
{
  pkgs,
  modulesPath,
  lib,
  ...
}@args:
{
  networking.hostName = lib.mkDefault "minimal";
  system.stateVersion = lib.mkDefault "26.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/installer/cd-dvd/latest-kernel.nix")
  ];
  environment.systemPackages = with pkgs; [
    brightnessctl
    grc
    chafa
    cht-sh
    coreutils-full
    sysstat

    multitail
    disko
    duf
    dust
    fastfetch
    fd
    file
    fswatch
    fwupd
    fzf
    fzy
    gdu
    git
    git
    glib
    groff
    gzip
    highlight
    htop
    hyperfine
    imagemagick
    inotify-tools
    jmtpfs
    jq
    kmon
    lazygit
    lf
    libnotify
    libwebp
    lm_sensors
    man-pages
    man-pages-posix
    manix
    mtools
    nfs-utils
    nps
    parallel
    parted
    pciutils
    pistol
    procps
    psmisc
    pv
    qemu
    remarshal
    reptyr
    ripgrep
    silver-searcher
    systemctl-tui
    sysz
    tldr
    translate-shell
    trash-cli
    udevil
    ueberzugpp
    unrar
    unzip
    usbutils
    utf8proc
    w3m
  ];

  programs.tmux.enable = true;
  programs.tmux.extraConfig = ''

  '';
  environment.etc."lfrc".text = ''
    set nohidden
  '';
  # dns https://wiki.nixos.org/wiki/NetworkManager#DNS_Management
  # iwd https://nixos.wiki/wiki/Iwd
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.networkmanager.wifi.backend = "iwd";
  # netstat -antup
  # nestat --all --numeric --tcp --udp --program
  networking.enableIPv6 = false;
  boot.kernelParams = [ "ipv6.disable=1" ];

  # networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    # https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/iwd.config.rst
    # General.EnableNetworkConfiguration = true;
    # General.RoamThreshold = "-70"; # -70
    # General.RoamThreshold5G = "-76";
    # General.CriticalRoamThreshold = "-80";
    # General.CriticalRoamThreshold5G = "-82";
    # General.RoamRetryInterval = 60;
    IPv4.SendHostname = true;
    Network.NameResolvingService = "resolvconf"; # Values: resolvconf, **systemd**, none
    Network.EnableIPv6 = false;
    Settings.AutoConnect = true;
    Scan.DisablePeriodicScan = true;
    Scan.DisableRoamingScan = true;
  };
  time.timeZone = "Europe/Vilnius";
  # SSH https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#SSH
  # https://nixos.wiki/wiki/SSH_public_key_authentication
  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  console.useXkbConfig = true;
  users.defaultUserShell = pkgs.zsh;
  users.users."root".shell = pkgs.zsh;
  users.users."root".extraGroups = [ ];
  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIrYp7DZHd8mJjmtXwrrjQW5e207eCU/KTROwxl2jdnf"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRxm8QUHcJJmYlI1vzlKsukRm05WuTCZ85rJZgzB2sh"
  ]
  ++ (args.extraPublicKeys or [ ]);

  environment.etc."disko-main.nix".source = ./disko-main.nix;
  # static_ip https://nixos.wiki/wiki/Creating_a_NixOS_live_CD#Static_IP_Address
  # wifi https://nixos.org/manual/nixos/stable/index.html#sec-building-image-drivers
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes pipe-operators";
  programs.git.enable = true;
  # environment.etc."gitconfig".source = ./.config/git/config_global;
  # programs.git.package = pkgs.gitFull;
  # programs.git.lfs.enable = true;
  programs.git.config = [
    {
      core = {
        sshCommand = "ssh -i ~/.ssh/id_ed25519";
      };
      user = {
        email = "kalesnykas.aivaras@gmail.com";
        name = "Aivaras Kalesnykas";
      };
      # credential = {
      # helper = "manager";
      # "https://github.com".username = "kalesnykas.aivaras@gmail.com";
      # "https://github.com".username = "aivarask";
      # credentialStore = "cache";
      # };
      init = {
        defaultBranch = "main";
      };
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };
    }
  ];

  programs.bash.interactiveShellInit = ''
    alias iwconnect="iwctl station wlan0 connect zte"
    alias disko_prepare="disko -m destroy,format,mount"

    # https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
    # /etc/nixos/bashrc.local
  '';
  environment.etc."bashrc.local".source = "/etc/nixos/bash/bashrc.local";

  fonts.enableDefaultPackages = true;
  fonts.fontconfig.antialias = true;
  fonts.fontconfig.hinting.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    papirus-icon-theme
    material-design-icons
    # liberation_ttf
    # terminus_font_ttf
    # lato
    # nerd-fonts.symbols-only
    # nerd-fonts.dejavu-sans-mono
    # nerd-fonts.fira-mono
    # nerd-fonts.fira-code
    # powerline-fonts
    # font-awesome
    # noto-fonts
    # noto-fonts-color-emoji
    # noto-fonts-monochrome-emoji
  ];
  # https://github.com/kamlendras/waybar-macos-sequoia/blob/main/config
  fonts.fontconfig.defaultFonts.serif = [
    "DejaVu Serif"
    # "Noto Color Emoji"
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "DejaVu Sans"
    # "Noto Color Emoji"
  ];
  fonts.fontconfig.defaultFonts.monospace = [
    "Hack Nerd Font Mono"
    "Liberation Mono"
    # "DejaVuSansM Nerd Font Mono"
    # "Noto Color Emoji"
  ];
  fonts.fontconfig.defaultFonts.emoji = [
    "Hack Nerd Font Mono"
    "Liberation Mono"
    # "Twitter Color Emoji"
    # "Noto Color Emoji"
    # "DejaVuSansM Nerd Font"
  ];
  environment.variables.MANPAGER = "less -R --use-color -Dd+r -Du+b";
  environment.variables.MANROFFOPT = "-P -c";
  # environment.etc.nixos-docs.source = "${config.system.build.manual.manualHTML}/share/doc/nixos/";

  documentation.enable = true;
  documentation.dev.enable = false;
  documentation.doc.enable = true;
  documentation.info.enable = true;
  documentation.nixos.enable = true;
  documentation.nixos.includeAllModules = true;
  documentation.man.enable = true;
  documentation.man.man-db.enable = false;
  documentation.man.mandoc.enable = false;
  documentation.man.mandoc.settings.manpath = [ "/run/current-system/sw/share/man" ];

  i18n.defaultLocale = "C.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  location.provider = lib.mkDefault "manual";
  location.latitude = 54.0;
  location.longitude = 25.0;

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "kalesnykas.aivaras@gmail.com";
  security.acme.defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  security.sudo.wheelNeedsPassword = false;
  security.pam.services.nginx.setEnvironment = false;

}
