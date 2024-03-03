{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim-vint
    nodePackages.vim-language-server
  ];
}
