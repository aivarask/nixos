{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lesspipe
  ];
  programs.less = {
    enable = true;
  };
}
