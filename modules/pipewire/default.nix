# https://wiki.nixos.org/wiki/PipeWire
# https://nixos.org/manual/nixos/unstable/options#opt-services.pipewire.enable
# https://docs.pipewire.org/page_config.html
# pactl list sink-inputs
# https://github.com/mikeroyal/PipeWire-Guide
# pactl list sink-
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
    # easyeffects
  ];
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.jack.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.systemWide = true;
  systemd.user.services.wireplumber.wantedBy = [ "default.target" ];
  users.users."root".linger = true;
  users.users."root".extraGroups = [
    "audio"
    "pipewire"
  ];

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
  services.pipewire.extraConfig.pipewire = {
    "98-crackling-fix" = {
      "context.properties" = {
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 1024;
        "default.clock.max-quantum" = 8192;
      };
    };
  };

  # additional fix for very bad devices or VM.
  services.pipewire.wireplumber.extraConfig = {
    "99-crackling-fix" = {
      "api.alsa.period-size" = 1024;
      "api.alsa.headroom" = 8192;
    };
  };
}
