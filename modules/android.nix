{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    # scrcpy
    # qtscrcpy
    # android-file-transfer
    # android-tools
  ];
}
