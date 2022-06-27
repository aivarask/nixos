{ config, pkgs, lib, ... }: {
  imports = [
    ./alacritty.nix
    ./sxhkd.nix
    ./bat.nix
    ./git.nix
    ./lf.nix
    ./firefox.nix
    ./zsh.nix
    ./fzf.nix
    ./xinitrc.nix
    ./glow.nix
    ./pistol.nix
    ./vim
  ];

  # TODO: https://rycee.gitlab.io/home-manager/options.html#opt-gtk.theme


  home.stateVersion = "18.09";
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500; # 5500
      night = 4500; # 3700
    };
    latitude = 54.00;
    longitude = 25.00;
    provider = "manual";
  };

  services.dunst = {
    enable = true;
  };

  services.unclutter = {
    enable = true;
    timeout = 2;
  };

  programs.ncmpcpp = {
    enable = true;
    settings = {
      "allow_for_physical_item_deletion" = "yes";
      "user_interface" = "alternative";
      "alternative_header_first_line_format" = "$b$5«« {%a}|{%t} »»$9$/b";
      alternative_header_second_line_format = "$b$5 {%b}|{%f} {%b} ({%y})$9$/b";
      song_columns_list_format = "(40)[blue]{a|f} (40)[green]{tE} (20)[blue]{bE}";
    };
  };


}
