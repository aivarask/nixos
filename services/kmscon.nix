{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ kmscon ];
  # services.kmscon.hwRender = false;
  # services.kmscon.extraOptions = "no-drm";
  services.kmscon.extraConfig = "
	font-dpi=192 # 96
# font-size=14 # 12
";

  services.kmscon = {
    enable = lib.mkDefault false;
    # autologinUser = lib.mkDefault "root";
    useXkbConfig = lib.mkDefault true;
    # hwRender = lib.mkDefault true;
  };
}
