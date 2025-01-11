{ ... }:
{
  environment.sessionVariables.LAZYGIT_CONFIG = "/etc/nixos/programs/lazygit.yml";
  environment.shellAliases.lazygit_ = "lazygit -ucf $LAZYGIT_CONFIG";
  environment.shellAliases."\\l" = "lazygit_";
  programs.lazygit.enable = true;
}
