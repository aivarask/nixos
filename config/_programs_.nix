# vim:fdl=4
{ pkgs, osConfig, ... }:
{
  programs.kitty = {
    enable = true;
  };
  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;
  programs.nix-index.enableZshIntegration = true;
  programs.nix-index.enableBashIntegration = true;
  programs.lazygit.enable = true;
  programs.eza = {
    enable = true;
    icons = "auto";
    enableZshIntegration = false;
  };
  # home.shellAliases.alacritty = "alacritty --config-file=/etc/nixos/config/files/alacritty.toml";
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        ./files/gruvbox.toml
        "/etc/nixos/config/files/a_pc.toml"
      ];
      font.size = if osConfig.networking.hostName == "dell" then 8 else 24;
      keyboard = {
        bindings = [
          {
            key = "Return";
            mods = "Control";
            action = "SpawnNewInstance";
          }
        ];
      };
    };
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
      pager = "less -R";
      style = "numbers,changes,header";
      map-syntax = [
        "bashrc:Bourne Again Shell (bash)"
        "zshrc:Bourne Again Shell (bash)"
        "zshenv:Bourne Again Shell (bash)"
        "*.postcss:CSS"
        "*.prisma:GraphQL"
        "*.mdx:Markdown"
        "flake.lock:JSON"
      ];
    };
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
      batpipe
      batwatch
      batdiff
      prettybat
    ];
  };
  home.packages = with pkgs; [
    chromedriver
    vimpager
  ];
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    commandLineArgs = [
      "--no-sandbox"
      "--no-default-browser-check"
      # "--remote-debugging-port=9222"
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "aghfnjkcakhmadgdomlmlhhaocbkloab"; } # just-black
    ];
  };
  programs.nushell.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      load_dotenv = true;
    };
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-eco
      # gh-poi
      # gh-dash
      # sh-screensaver
      # gh-actions-cache
      gh-markdown-preview
    ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
  programs.ncmpcpp = {
    enable = true;
    settings = {
      # https://github.com/ncmpcpp/ncmpcpp/blob/master/doc/config
      # https://raw.githubusercontent.com/ncmpcpp/ncmpcpp/master/doc/config
      mpd_music_dir = "/var/music";
      connected_message_on_startup = "no";
      display_bitrate = "yes";
      playlist_show_mpd_host = "no";
      allow_for_physical_item_deletion = "yes";
      "user_interface" = "alternative";
      "alternative_header_first_line_format" = "$b$5 {%a}|{%t} $9$/b";
      alternative_header_second_line_format = "$b$5 {%b}|{%f} {%b} ({%y})$9$/b";
      song_columns_list_format = "(40)[blue]{a|f} (40)[green]{tE} (20)[blue]{bE}";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      package.disabled = true;
      golang.disabled = true;
      lua.disabled = true;
      nodejs.disabled = true;
      php.disabled = true;
      rust.disabled = true;
    };
  };
  programs.zathura.enable = true;
}
