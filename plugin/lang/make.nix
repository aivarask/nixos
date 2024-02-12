{ pkgs, ... }: {
  environment.shellAliases = {
    "checkmake" = "checkmake --config=/etc/nixos/checkmake.ini";
  };
  environment.systemPackages = with pkgs; [ gnumake checkmake ];
}
