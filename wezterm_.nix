{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    # https://wezterm.org/config/files.html
    # https://github.com/nix-community/home-manager/blob/master/modules/programs/wezterm.nix
    # https://github.com/wezterm/wezterm/issues
    extraConfig = ''
      local config = wezterm.config_builder()
      return config
    '';
  };
}
