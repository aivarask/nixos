{...}: {
  imports = [
    ./config/boot.nix
    ./config/fonts.nix
    ./config/nix.nix
    ./config/nixpkgs.nix
    ./config/powerManagement.nix
    ./config/programs.nix
    ./config/services.nix
    ./xserver.nix
    ./sql
    ./systemd.nix
    ./config/cron.nix
    ./config/users.nix
    ./config/virtualisation.nix
    ./config/mpd.nix
    # ./config/pipeWire.nix
    ./config/tmux.nix
    ./security.nix
    ./nginx
    ./environment.nix
    ./LF_ICONS.nix
    ./systemPackages
    ./xdg.nix
  ];

  # moz-extension://cd54c47b-5f75-4660-a7fb-767b63a96a36/home.html#initialize/seed-phrase
  # lobster harbor kingdom combine filter base suggest badge wood measure pelican future

  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiko5+WigWfHzZsniVYM184iC4JoZ0MZl+KbZIajY914/IPPLR00mKX+Aaxkjci6nMTUym9UjITtnCDO5lDTOI8Qyb1oDCUGUxVdgryRpGtEcV6Wg8kgRVDEIeAdKTy8LVWW6ZC25bJiOP/WMBppQcaL74MgxDrMQtw8BBo8xDObZxnnFz7gizg8Lbkruf2IkReKj174Pu6zFeHcbPLI8bR/noFqIe0Vk2UDV5g5f9lonsdtlV3DCvbOX9aopWtX1f5ueiCPuAT+00UB5jgC7+bmXzlayGDGNL3k6Qeqs3gmSObGQXcWwNO4CblnkR2ITzKUY2p2nZrFfJE1PHr4KzCzSRJpZi8/iz3i0+8se8vVb28GF3T2FGwwzXAHjp6QwNo2orqWeIo+Dzz4slnzkeMaIPBvkqstIP2v7vUTUMuTuQN+Ouu6y3p2IZfCFDWlTB/Wlf+JEVT4F1FA45RmFGm9ud09okrnt1fkwnr59zk2N8JiIQcGn6lCuzDjHobgM= root"
  ];
}
