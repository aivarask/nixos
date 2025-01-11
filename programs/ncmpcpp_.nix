{ ... }:
{
  environment.sessionVariables.NCMPCPP_CONFIG = "/etc/nixos/programs/ncmpcpp_config";
  environment.sessionVariables.NCMPCPP_BINDINGS = "/etc/nixos/programs/ncmpcpp_bindings";
  environment.shellAliases.ncmpcpp_ = "ncmpcpp -c $NCMPCPP_CONFIG -b $NCMPCPP_BINDINGS";
  programs.ncmpcpp = {
    enable = true;
  };
}
