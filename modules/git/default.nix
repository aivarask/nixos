{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        pkgs,
        config,
        ...
      }:
      {
        home.packages = with pkgs; [
          git
          git-lfs
          git-crypt
          pre-commit
          delta
          lazygit
          difftastic
          diff-so-fancy
          python3Packages.ydiff
          patchutils
        ];
        programs.git.enable = true;
        # programs.git.package = pkgs.gitFull;
        programs.git.lfs.enable = true;
        programs.git.maintenance.enable = true;
        programs.git.settings.include.path = [
          "/etc/nixos/modules/git/config_system"
        ];

        xdg.configFile."git/config_system".source =
          config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/git/config_system";
        xdg.configFile."git/ignore".source =
          config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/git/ignore";

      }
    )
  ];
}
