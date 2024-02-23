{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    shellcheck # 35k
    dotenv-linter # 1.7k
    beautysh # 420
    shellharden # 4.5k
    shfmt # 6.6k
    nodePackages.bash-language-server # 2k
  ];
}

