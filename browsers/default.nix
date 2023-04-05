{ ... }: {
  imports = [ ./firefox.nix ];

  home.sessionVariables = {
    BROWSER = "firefox";
    MOZ_USE_XINPUT2 = "1";
    MOZ_X11_EGL = "1";
  };
  home.shellAliases = {
    brave = "brave --no-sandbox";
  };
  programs.chromium = {
    enable = true;
    commandLineArgs = [ "--no-sandbox" ];
    extensions = [
      # "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # uBlock Origin
      }
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb"; # vimium
      }
    ];
  };
}
