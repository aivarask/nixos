{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
    ]
    ++ (with pkgs.nodePackages_latest; [
      prettier
    ]);
}
