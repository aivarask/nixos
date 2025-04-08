# https://wiki.nixos.org/wiki/PipeWire
# https://nixos.org/manual/nixos/unstable/options#opt-services.pipewire.enable
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=pipewire
    alsa-utils
    pavucontrol
    pulsemixer
    pwvucontrol
    coppwr
    qpwgraph
    sonusmix
    wireplumber
  ];
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    systemWide = true;
  };
  # systemd.user.services.wireplumber.wantedBy = [ "default.target" ];
  # users.users."root".linger = true; # keep user services running
  # users.users."root".extraGroups = [ "audio" ];

  services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
    "context.properties" = [
      {
        name = "libpipewire-module-protocol-pulse";
        args = { };
      }
    ];
    "pulse.properties" = {
      "pulse.min.req" = "32/48000";
      "pulse.default.req" = "32/48000";
      "pulse.max.req" = "32/48000";
      "pulse.min.quantum" = "32/48000";
      "pulse.max.quantum" = "32/48000";
    };
    "stream.properties" = {
      "node.latency" = "32/48000";
      "resample.quality" = 1;
    };
  };
}
