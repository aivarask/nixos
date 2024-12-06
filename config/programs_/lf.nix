{ ... }:
{
  xdg.configFile."lf/icons".source = ./lf_icons;
  programs.lf = {
    extraConfig = ''
      source /etc/nixos/config/programs_/lfrc
    '';
    # ~/.config/lf/lfrc
    enable = true;
    settings = {
      hidden = true;
      icons = true;
      ifs = "\n";
      info = "size";
      ratios = "1:2";
      scrolloff = 8;
      shell = "zsh";
      shellopts = "-ey";
    };
    commands = {
      # get-mime-type = ''%xdg-mime query filetype "$f"'';
      # open = "$$OPENER $f";
      # touch = ''%touch "$@"'';
      # mkdir = ''%mkdir "$@"'';
    };
    keybindings =
      {
      };
    cmdKeybindings = { };
  };
}
