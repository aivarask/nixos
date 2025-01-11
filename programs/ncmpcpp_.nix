{ ... }:
{
  home.sessionVariables.NCMPCPP_CONFIG = "/etc/nixos/programs/ncmpcpp_config";
  home.sessionVariables.NCMPCPP_BINDINGS = "/etc/nixos/programs/ncmpcpp_bindings";
  home.shellAliases.ncmpcpp_ = "ncmpcpp -c $NCMPCPP_CONFIG -b $NCMPCPP_BINDINGS";
  programs.ncmpcpp = {
    enable = true;
  };
}
