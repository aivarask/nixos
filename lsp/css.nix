{ pkgs, ... }: {
  environment.shellAliases = {
    stylelint = "stylelint -c /etc/nixos/.stylelintrc.json --config-basedir /etc/nixos";
  };
  environment.systemPackages = with pkgs; [
    # vscode-langservers-extracted
    stylelint
  ];
}
