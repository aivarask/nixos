{ config, pkgs, ... }: {

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  services.gitolite = {
    enable = false;
    adminPubkey = ''
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCVeRbpc6UXV5bYFPrBPBl7P5nEKeG97sMprOZpgkzx1/PTAvnN0Lpcf7fIplfQ22o+zATGANbhWIRp7jxPLMi0NFUMwu+gyCYSfdgAhqLTNnBCsOtpoaLcVolvXDjvuYTk3tBcSm9GKtbfVRRLfrkNmkfzLyxnA+P1O8qDds1m6U+FWkBk8UmFDITQcmN5RO9nHfLdk3i+k8dUTmxTqe4jrvoGLk3OnUaTOPTVBi4pBPFMYtKJpGIoFg1SlZjI1A/TwUwpUCleE96bC92dJ37LK2Hkh+mT51urC74epfVqDOyk8x7SRSbqE7GFLC5qIZFSBsy2HV3TMZ4P3RN8G5nA8htMv9GeCVua9gSDkZTHzhOZdb9r/xViSgjLKFmX72HMJbs2nBp7BUVeNs4xmAhaxga8btz5GOtOkxcngKU72SpFiWRFxPu8opscEvzmFC3vUaBffSzCBBfY+pUOO5BXtC0c3mccYDgltz5om0i7Q4k2XhwxoYgI86IvTbTublE= root@pc
    '';
  };

  services.xserver = {
    enable = true;
    libinput.enable = true;
    layout = "us,lt";
    # xkbVariant = "workman,"; # localectl list-x11-keymap-variants
    xkbOptions = "grp:lwin_toggle,"; # localectl list-x11-keymap-options
    imwheel = {
      enable = true;
      rules = {
        # imwheel -d --debug --kill
        # ".*" = ''
        "^(vieb|firefox|brave-browser|google-chrome-stable|google-chrome|telegram-desktop)$" = ''
          None, Up, Button4, 4
          None, Down, Button5, 4
          Shift_L,   Up,   Shift_L|Button4, 4
          Shift_L,   Down, Shift_L|Button5, 4
          Control_L, Up,   Control_L|Button4
          Control_L, Down, Control_L|Button5
        '';
      };
      # extraOptions = [ "--buttons=45" ];
    };
    displayManager.startx.enable = true;
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    # desktopManager.plasma5.enable = true;

    # displayManager.autoLogin = {
    #   enable = true;
    #   user = "ak";
    # };
  };

  services.transmission = {
    enable = true;
    settings = {
      watch-dir = "/root/Downloads";
      watch-dir-enabled = true;
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureDatabases = [
      "ak"
      "sand"
      "fixasparts"
    ];
    ensureUsers = [
      {
        name = "ak";
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
    ];
    settings = {
      mysql = {
        auto-rehash = true;
      };
    };
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE root WITH LOGIN PASSWORD 'root' CREATEDB;
      CREATE DATABASE root;
      GRANT ALL PRIVILEGES ON DATABASE root TO root;
    '';
  };

  services.mongodb = {
    enable = true;
  };
}
