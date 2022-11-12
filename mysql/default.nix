{ config, pkgs, lib, ... }: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/databases/mysql.nix
    ensureDatabases = [
      "ak"
      "sand"
      "fixasparts"
      "playground"
      "johndoe"
    ];
    ensureUsers = [
      {
        name = "ak"; # l
        ensurePermissions = {
          "ak.*" = "ALL PRIVILEGES";
        };
      }
      {
        name = "sand";
        ensurePermissions = {
          "sand.*" = "ALL PRIVILEGES";
        };
      }
      {
        name = "fixas";
        ensurePermissions = {
          "fixasparts.*" = "ALL PRIVILEGES";
          "sand.*" = "ALL PRIVILEGES";
          # GRANT ALL PRIVILEGES ON fixasparts.* TO 'fixas'@'localhost';
        };
      }
      {
        name = "johndoe";
        ensurePermissions = {
          "johndoe.*" = "ALL PRIVILEGES";
        };
      }
    ];
    settings = {
      mysql = {
        auto-rehash = true;
      };
    };
  };
}

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mariadb;
  #   ensureDatabases = [
  #     "ak"
  #     "sand"
  #     "fixasparts"
  #     "playground"
  #     "johndoe"
  #   ];
  #   ensureUsers = [
  #     {
  #       name = "ak"; # l
  #       ensurePermissions = {
  #         "ak.*" = "ALL PRIVILEGES";
  #       };
  #     }
  #     {
  #       name = "sand";
  #       ensurePermissions = {
  #         "sand.*" = "ALL PRIVILEGES";
  #       };
  #     }
  #     {
  #       name = "fixas";
  #       ensurePermissions = {
  #         "fixasparts.*" = "ALL PRIVILEGES";
  #         "sand.*" = "ALL PRIVILEGES";
  #         # GRANT ALL PRIVILEGES ON fixasparts.* TO 'fixas'@'localhost';
  #       };
  #     }
  #     {
  #       name = "johndoe";
  #       ensurePermissions = {
  #         "johndoe.*" = "ALL PRIVILEGES";
  #       };
  #     }
  #   ];
  #   settings = {
  #     mysql = {
  #       auto-rehash = true;
  #     };
  #   };
  # };

