{ ... }:
{
  home.sessionVariables.LAZYGIT_CONFIG = "/etc/nixos/programs/lazygit.yml";
  home.shellAliases.lazygit_ = "lazygit -ucf $LAZYGIT_CONFIG";
  home.shellAliases."\\l" = "lazygit_";
  programs.lazygit.enable = true;
}
