{
  outputs = _: {
    nixosModules.default =
      { pkgs, lib, ... }:
      {
        # programs.git.enable = true;
        # environment.etc."gitconfig".source = lib.mkForce "/etc/nixos/_git/gitconfig";
        # programs.git.
        environment.systemPackages = with pkgs; [
          git
          git-lfs
          gh
          git-crypt
          pre-commit
        ];
      };
    nixosModules.home =
      { pkgs, config, ... }:
      {
        programs.git.package = pkgs.gitFull;
        programs.git.enable = true;
        programs.git.lfs.enable = true;
        programs.git.extraConfig = {
          include.path = "/etc/nixos/_git/config_user";
        };
        xdg.configFile."git/config_global".source =
          config.lib.file.mkOutOfStoreSymlink "/etc/nixos/_git/config_global";
        xdg.configFile."git/config_user".source =
          config.lib.file.mkOutOfStoreSymlink "/etc/nixos/_git/config_user";
        xdg.configFile."git/ignore".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/_git/ignore";
      };
  };
}
