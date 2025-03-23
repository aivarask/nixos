{ config, ... }:
{
  services.kmscon = {
    hwRender = true;
    # https://discourse.nixos.org/t/services-kmscon-keyboard-repeat-rate/48619
    # https://www.reddit.com/r/linux/comments/oaaps/whats_the_default_keyboard_repeat_rate_in_an/
    # https://ubuntuhandbook.org/index.php/2021/08/enable-hardware-video-acceleration-va-api-for-firefox-in-ubuntu-20-04-18-04-higher/
    extraConfig = ''
      kbdrate -d 250 -r 50
      font-dpi=${toString config.services.xserver.dpi}
    '';
  };
}
