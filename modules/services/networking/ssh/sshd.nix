_: {
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
    };
  };
  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiko5+WigWfHzZsniVYM184iC4JoZ0MZl+KbZIajY914/IPPLR00mKX+Aaxkjci6nMTUym9UjITtnCDO5lDTOI8Qyb1oDCUGUxVdgryRpGtEcV6Wg8kgRVDEIeAdKTy8LVWW6ZC25bJiOP/WMBppQcaL74MgxDrMQtw8BBo8xDObZxnnFz7gizg8Lbkruf2IkReKj174Pu6zFeHcbPLI8bR/noFqIe0Vk2UDV5g5f9lonsdtlV3DCvbOX9aopWtX1f5ueiCPuAT+00UB5jgC7+bmXzlayGDGNL3k6Qeqs3gmSObGQXcWwNO4CblnkR2ITzKUY2p2nZrFfJE1PHr4KzCzSRJpZi8/iz3i0+8se8vVb28GF3T2FGwwzXAHjp6QwNo2orqWeIo+Dzz4slnzkeMaIPBvkqstIP2v7vUTUMuTuQN+Ouu6y3p2IZfCFDWlTB/Wlf+JEVT4F1FA45RmFGm9ud09okrnt1fkwnr59zk2N8JiIQcGn6lCuzDjHobgM= root"
  ];
}
