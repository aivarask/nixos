config: {
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
}
