# https://wiki.nixos.org/wiki/PipeWire
# https://nixos.org/manual/nixos/unstable/options#opt-services.pipewire.enable
# https://docs.pipewire.org/page_config.html
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
    pulsemixer
    pwvucontrol
    coppwr
    wireplumber
    # qpwgraph
    # pulseaudio
  ];
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.systemWide = true;
  # systemd.user.services.wireplumber.wantedBy = [ "default.target" ];
  users.users."root".linger = false;
  users.users."root".extraGroups = [ "audio" ];

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
