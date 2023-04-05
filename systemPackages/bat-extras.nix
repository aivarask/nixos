{ pkgs, ... }: {
  environment.systemPackages = with pkgs.bat-extras; [
    batgrep
    batman
    batpipe
    batwatch
    batdiff
    prettybat
  ];
}
