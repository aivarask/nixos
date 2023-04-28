{pkgs, ...}: {
  hardware.pulseaudio = {
    enable = true;
    systemWide = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
    tcp = {
      enable = true;
      anonymousClients.allowedIpRanges = [
        "127.0.0.1"
        "0.0.0.0"
      ];
    };
  };
}
