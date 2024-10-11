{ pkgs, osConfig, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ ./a_gruvbox.toml ];
      font.size = if osConfig.networking.hostName == "dell" then 8 else 12;
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
  home.sessionVariables.BAT_THEME = "gruvbox-dark";
  programs.bat = {
    enable = true;
    config = {
      pager = "less -R";
      style = "numbers,changes,header";
      map-syntax = [
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
  home.packages = with pkgs; [ chromedriver ];
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
  programs.kitty.enable = true;
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

  home.shellAliases.fzp = "fzf -m --preview 'pistol {}'";
  programs.fzf = {
    # https://github.com/junegunn/fzf#usage
    # https://github.com/nix-community/home-manager/blob/master/modules/programs/fzf.nix
    enable = true;
    defaultCommand = "fd -tf";
    defaultOptions = [
      "--layout=reverse"
      "--preview-window up"
      "--bind ']:toggle-preview'"
      "--bind 'ctrl-]:change-preview-window(right|up)'"
      "--bind 'f1:execute(bat {})'"
      "--bind 'ctrl-y:execute-silent(echo {} | xclip -selection clipboard)+abort'"
      "--bind 'ctrl-e:become(nvim {})'"
      "--bind 'ctrl-f:reload(fd -tf)'"
      "--bind 'ctrl-d:reload(fd -td)'"
    ];
    fileWidgetCommand = "fd --type f"; # Ctrl-t
    fileWidgetOptions = [ "--preview 'pistol {}'" ];
    changeDirWidgetCommand = "fd --type d"; # Alt-c
    changeDirWidgetOptions = [ "--preview 'pistol {}'" ];
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

      ###
      "user_interface" = "alternative";
      "alternative_header_first_line_format" = "$b$5«« {%a}|{%t} »»$9$/b";
      alternative_header_second_line_format = "$b$5 {%b}|{%f} {%b} ({%y})$9$/b";
      song_columns_list_format = "(40)[blue]{a|f} (40)[green]{tE} (20)[blue]{bE}";

      ###
      display_bitrate = "yes";
      playlist_show_mpd_host = "no";
      allow_for_physical_item_deletion = "yes";
      connected_message_on_startup = "no";
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

      lua = {
        disabled = true;
      };
      nodejs = {
        disabled = true;
      };
      php = {
        disabled = true;
      };
      rust = {
        disabled = true;
      };
    };
  };
}
