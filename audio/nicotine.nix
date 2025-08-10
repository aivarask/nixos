{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    nicotine-plus
    slskd
  ];
  # xdg.configFile."nicotine/config" = {
  #   enable = false;
  #   # force = true;
  #   source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/audio/nicotine";
  # };
  # xdg.configFile = {
  #   "nicotine/config_def" = {
  #     source = ./nicotine;
  #     enable = true;
  #     recursive = true;
  #     onChange = ''
  #       cat ${config.home.homeDirectory}/.config/nicotine/config_def > ${config.home.homeDirectory}/.config/nicotine/config
  #     '';
  #   };
  # };
}
