{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
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
}
