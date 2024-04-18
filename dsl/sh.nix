{ pkgs, ... }: {
  environment.variables = {
    # BASHDB_DIR = "${pkgs.bashdb.outPath}";
  };
  environment.systemPackages = with pkgs; [
    # shellcheck # 35k # depr
    dotenv-linter # 1.7k
    # beautysh # 420 # depr
    shellharden # 4.5k
    shfmt # 6.6k
    nodePackages.bash-language-server # 2k
    # bashdb
  ];
}

