{
  inputs.nixpkgs.url = "nixpkgs";
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";
    in
    {
      nixosModules = {
        env.sys =
          { ... }:
          {
            environment.profiles = [ "${./.}" ];
            # /etc/profile
            programs.bash.shellInit = ''# OS programs.bash.shellInit '';
            environment.shellInit = ''
              # OS environment.shellInit
              # source /etc/nixos/profile
            '';
            # /etc/set-environment
            environment.extraInit = ''# OS environment.extraInit '';
            # /etc/bashrc
            programs.bash.interactiveShellInit = ''# OS programs.bash.interactiveShellInit '';
            environment.interactiveShellInit = ''# OS environment.interactiveShellInit '';
            # /etc/zshenv /etc/zshrc
            programs.zsh.enable = true;
            programs.zsh.shellInit = ''# OS programs.zsh.shellInit '';
          };
        env.hm =
          { ... }:
          {
            # /etc/profiles/per-user/root/etc/profile.d/hm-session-vars.sh
            # https://mynixos.com/home-manager/options/xsession
            xsession.enable = true;
            xsession.profileExtra = ''# HM xsession.profileExtra '';
            xsession.initExtra = ''# HM xsession.initExtra '';
            programs.bash.enable = true;
            programs.bash.profileExtra = ''# HM programs.bash.profileExtra '';
            programs.bash.initExtra = ''# HM programs.bash.initExtra '';
            programs.zsh.enable = true;
            programs.zsh.profileExtra = ''# HM programs.zsh.profileExtra '';
            programs.zsh.initExtraBeforeCompInit = ''# HM programs.zsh.initExtraBeforeCompinit '';
            programs.zsh.completionInit = ''# HM programs.zsh.completionInit '';
            programs.zsh.initExtra = ''
               # programs.zsh.initExtra
              source /etc/nixos/zsh/zshrc
            '';
          };
        zsh =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              zed-editor
              bash-language-server
              shellcheck
              shfmt
              dotenv-linter
              shellharden
            ];
            home.sessionPath = [ "/root/woo/bin" ];
            home.sessionVariables.AIVA = "1";

            programs.zsh.autocd = true;
            programs.zsh.syntaxHighlighting.enable = true;
            programs.zsh.autosuggestion.enable = true;
            programs.zsh.dotDir = ".config/zsh";
            programs.zsh.history.size = 10000;
            programs.zsh.history.extended = true;
            programs.zsh.plugins = [
              # {
              #   name = "vi-mode";
              #   src = pkgs.zsh-vi-mode; # https://github.com/jeffreytse/zsh-vi-mode
              #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
              # }
              # {
              #   name = "system-clipboard";
              #   src = pkgs.zsh-system-clipboard; # https://github.com/kutsan/zsh-system-clipboard
              #   file = "share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh";
              # }
            ];

          };
        fzf =
          { config, ... }:
          {
            home.file.".ripgreprc".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/zsh/ripgreprc";
            programs.fzf.enable = true;
            programs.fzf.enableBashIntegration = true;
            programs.fzf.enableZshIntegration = true;
            # fileWidgetCommand = "fd -tf --exclude '*.drv'"; # Ctrl-t
            # changeDirWidgetCommand = "fd -td"; # Alt-c
            # defaultCommand = "fd -tf -H --exclude  '*.drv'"; # Ctrl-f
            # defaultOptions = [
            #   # "--style full"
            #   # "--bind 'focus:transform-header:file --brief {}'"
            #   "--layout reverse"
            #   "--height 100%"
            #   "--preview 'pistol_ {}'"
            #   "--preview-window up"
            #   "--bind ']:toggle-preview'"
            #   "--bind 'ctrl-]:change-preview-window(right|up)'"
            #   "--bind 'ctrl-f:reload(fd -tf)'"
            #   "--bind 'ctrl-F:reload(fd -tf -H)'"
            #   "--bind 'ctrl-d:reload(fd -td)'"
            #   "--bind 'ctrl-D:reload(fd -td -H)'"
            #   "--bind 'ctrl-i:execute(bat {})'"
            #   "--bind 'ctrl-b:execute(file --mime-type {} | xargs notify-send)'"
            #   "--bind 'ctrl-y:execute-silent(echo {} | xclip -selection clipboard)+abort'"
            #   "--bind 'ctrl-e:become($EDITOR {})'"
            #   "--bind 'ctrl-o:become(xdg-open {})'"
            #   "--bind 'ctrl-h:become(fzf-man-widget {})'"
            #   "--bind 'ctrl-d:preview-down,ctrl-u:preview-up'"
            # ];
          };
      };
      checks."${system}".zsh = pkgs.testers.runNixOSTest {
        # https://github.com/NixOS/nix/blob/master/src/nix/flake-check.md
        name = "zsh";
        nodes.machine =
          { pkgs, ... }:
          {
            environment.systemPackages = [ pkgs.zsh ];
          };
        testScript = ''
          machine.start()
          machine.wait_for_unit("default.target")
          machine.succeed("which zsh")
        '';
      };
    };
}
