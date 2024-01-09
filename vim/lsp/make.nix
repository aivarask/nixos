{pkgs, ...}: {
  environment.shellAliases = {
    "checkmake" = "checkmake --config=${builtins.toString ./.}/checkmake.ini";
  };
  environment.systemPackages = [pkgs.gnumake pkgs.checkmake];
}
