{...}: let
  foo = "foo val";
  boo = "boo";
  home = builtins.getEnv "HOME";
  config = builtins.dirOf (builtins.findFile builtins.nixPath "nixos-config");
in {
  foo = "im interpolated ${foo}";
  home = "this is home: ${home}";
  boo = "im the booing: ${boo}";
  inherit config;
  # mmdc = "mmdc -p /etc/nixos/puppeteerConfigFile.json";
  # mmdc = "mmdc -p ${builtins.toString config}/puppeteerConfig.json";
  mmdz = "mmdc -p ${builtins.toString ./.}/puppeteerConfig.json";
}
