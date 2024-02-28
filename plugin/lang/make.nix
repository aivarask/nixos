{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gnumake
    checkmake
  ];
}
