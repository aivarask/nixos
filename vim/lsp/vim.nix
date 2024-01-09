{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim-vint
  ] ++ (with pkgs.nodePackages; [
    vim-language-server
  ]);
}
