{ inputs
, pkgs
, ...
}: {
  imports = [
    ./config/boot.nix
    ./config/fonts.nix
    ./config/nix.nix
    ./config/nixpkgs.nix
    ./config/powerManagement.nix
    ./config/programs.nix
    ./config/services.nix
    ./xserver.nix
    ./sql
    ./systemd.nix
    ./config/cron.nix
    ./config/users.nix
    ./config/virtualisation.nix
    ./config/mpd.nix
    # ./config/pipeWire.nix
    ./config/tmux.nix
    ./security.nix
    ./nginx
    ./environment.nix
    ./LF_ICONS.nix
    ./systemPackages
    ./xdg.nix
  ];

  # moz-extension://cd54c47b-5f75-4660-a7fb-767b63a96a36/home.html#initialize/seed-phrase
  # lobster harbor kingdom combine filter base suggest badge wood measure pelican future

  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "en_US.UTF-8";

  system.userActivationScripts.linktosharedfolder.text = ''
    ${pkgs.coreutils}/bin/ls > /root/greet
  '';

  system.userActivationScripts.test.text = ''
  '';

  nixpkgs = {
    overlays = [
      (_self: super:
        let
          emmet-ls = super.buildNpmPackage rec {
            # https://nixos.org/manual/nixpkgs/unstable/#javascript-tool-specific
            pname = "emmet-ls";
            src = inputs.emmet-ls;
          };
        in
        {
          nodePackages_latest =
            super.nodePackages_latest
            // {
              inherit emmet-ls;
            };
        })
      (_self: super:
        let
          vim-interestingwords = super.vimUtils.buildVimPluginFrom2Nix {
            name = "vim-interestingwords";
            src = inputs.vim-interestingwords;
          };
          nvim-lspconfig = super.vimUtils.buildVimPluginFrom2Nix {
            name = "nvim-lspconfig";
            src = inputs.nvim-lspconfig;
          };
          nvim-lsp-file-operations = super.vimUtils.buildVimPluginFrom2Nix {
            name = "nvim-lsp-file-operations";
            src = inputs.nvim-lsp-file-operations;
          };
          neodev-nvim = super.vimUtils.buildVimPluginFrom2Nix {
            name = "neodev-nvim";
            src = inputs.neodev-nvim;
          };
          typescript-nvim = super.vimUtils.buildVimPluginFrom2Nix {
            name = "typescript-nvim";
            src = inputs.typescript-nvim;
          };
          nvim-dap-vscode-js = super.vimUtils.buildVimPluginFrom2Nix {
            name = "nvim-dap-vscode-js";
            src = inputs.nvim-dap-vscode-js;
          };
          osv = super.vimUtils.buildVimPluginFrom2Nix {
            name = "osv";
            src = inputs.osv;
          };
          neotest = super.vimUtils.buildVimPluginFrom2Nix {
            name = "neotest";
            src = inputs.neotest;
          };
          neotest-playwright = super.vimUtils.buildVimPluginFrom2Nix {
            name = "neotest-playwright";
            src = inputs.neotest-playwright;
          };
          neotest-vim-test = super.vimUtils.buildVimPluginFrom2Nix {
            name = "neotest-vim-test";
            src = inputs.neotest-vim-test;
          };
          neotest-vitest = super.vimUtils.buildVimPluginFrom2Nix {
            name = "neotest-vitest";
            src = inputs.neotest-vitest;
          };
          neotest-plenary = super.vimUtils.buildVimPluginFrom2Nix {
            name = "neotest-plenary";
            src = inputs.neotest-plenary;
          };
          session-lens = super.vimUtils.buildVimPluginFrom2Nix {
            name = "session-lens";
            src = inputs.session-lens;
          };
          pretty-fold = super.vimUtils.buildVimPluginFrom2Nix {
            name = "pretty-fold";
            src = inputs.pretty-fold;
          };
          nvim-tree-lua = super.vimUtils.buildVimPluginFrom2Nix {
            name = "nvim-tree-lua";
            src = inputs.nvim-tree-lua;
          };
        in
        {
          vimPlugins =
            super.vimPlugins
            // {
              inherit vim-interestingwords;
              inherit nvim-lspconfig;
              inherit nvim-lsp-file-operations;
              inherit neodev-nvim;
              inherit typescript-nvim;
              inherit nvim-dap-vscode-js;
              inherit osv;
              inherit neotest;
              inherit neotest-playwright;
              inherit neotest-vim-test;
              inherit neotest-vitest;
              inherit neotest-plenary;
              inherit session-lens;
              inherit pretty-fold;
              inherit nvim-tree-lua;
            };
        })
    ];
  };

  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDiko5+WigWfHzZsniVYM184iC4JoZ0MZl+KbZIajY914/IPPLR00mKX+Aaxkjci6nMTUym9UjITtnCDO5lDTOI8Qyb1oDCUGUxVdgryRpGtEcV6Wg8kgRVDEIeAdKTy8LVWW6ZC25bJiOP/WMBppQcaL74MgxDrMQtw8BBo8xDObZxnnFz7gizg8Lbkruf2IkReKj174Pu6zFeHcbPLI8bR/noFqIe0Vk2UDV5g5f9lonsdtlV3DCvbOX9aopWtX1f5ueiCPuAT+00UB5jgC7+bmXzlayGDGNL3k6Qeqs3gmSObGQXcWwNO4CblnkR2ITzKUY2p2nZrFfJE1PHr4KzCzSRJpZi8/iz3i0+8se8vVb28GF3T2FGwwzXAHjp6QwNo2orqWeIo+Dzz4slnzkeMaIPBvkqstIP2v7vUTUMuTuQN+Ouu6y3p2IZfCFDWlTB/Wlf+JEVT4F1FA45RmFGm9ud09okrnt1fkwnr59zk2N8JiIQcGn6lCuzDjHobgM= root"
  ];
}
