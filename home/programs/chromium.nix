{ ... }: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--no-sandbox"
      "--enable-features=TouchpadOverscrollHistoryNavigation"
      "--no-default-browser-check"
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium 
      { id = "aghfnjkcakhmadgdomlmlhhaocbkloab"; } # just-black
    ];
  };
}
