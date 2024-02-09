{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    shellcheck
    shellharden
    shfmt
  ];
}

