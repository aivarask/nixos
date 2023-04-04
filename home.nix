# https://nix-community.github.io/home-manager/index.html#sec-usage-configuration
{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./sxhkd.nix
    ./bat.nix
    ./git.nix
    ./lf.nix
    ./firefox.nix
    ./zsh.nix
    ./fzf.nix
    ./glow.nix
    ./pistol.nix
    ./vim
  ];

  home = {
    stateVersion = "18.09";
    # TODO: https://rycee.gitlab.io/home-manager/options.html#opt-gtk.theme
    # Vanilla-DMZ
    file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
    file.".xinitrc".text = builtins.readFile ./xinitrc;
  };
  # xdg.configFile."nicotine/config".text = builtins.readFile ./nicotine/config;

  programs.chromium = {
    enable = true;
    commandLineArgs = [ "--no-sandbox" ];
    extensions = [
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # uBlock Origin
      }
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb"; # vimium
      }
    ];
  };
  services = {
    redshift = {
      enable = true;
      temperature = {
        day = 6500; # 5500
        night = 4500; # 3700
      };
      latitude = 54.0;
      longitude = 25.0;
      provider = "manual";
    };
    dunst = { enable = true; };
    unclutter = {
      enable = true;
      timeout = 2;
    };
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
