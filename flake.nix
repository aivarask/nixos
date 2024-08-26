{
  description = "NixOS config";
  inputs = {
    systems.url = "github:nix-systems/x86_64-linux";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    rust-overlay = { url = "github:oxalica/rust-overlay"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = "github:nix-community/NUR";
    dmenu-flexipatch = { url = "github:bakkeby/dmenu-flexipatch"; flake = false; };
    dwm-flexipatch = { url = "github:bakkeby/dwm-flexipatch"; flake = false; };
    st-flexipatch = { url = "github:bakkeby/st-flexipatch"; flake = false; };
    tabbed-flexipatch = { url = "github:bakkeby/tabbed-flexipatch"; flake = false; };
    LS_COLORS = { url = "github:trapd00r/LS_COLORS"; flake = false; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    vim-log-highlighting = { url = "github:MTDL9/vim-log-highlighting"; flake = false; };
    vim-interestingwords = { url = "github:lfv89/vim-interestingwords"; flake = false; };
    nvim-lsp-file-operations = { url = "github:antosha417/nvim-lsp-file-operations"; flake = false; };
    neotest-zig = { url = "github:lawrence-laz/neotest-zig"; flake = false; };
    nvim-dap-vscode-js = { url = "github:mxsdev/nvim-dap-vscode-js"; flake = false; };
    neotest-playwright = { url = "github:thenbe/neotest-playwright"; flake = false; };
    sxhkd-vim = { url = "github:kovetskiy/sxhkd-vim"; flake = false; };
    persistent-breakpoints = { url = "github:Weissle/persistent-breakpoints.nvim"; flake = false; };
    # rustaceanvim = { url = "github:mrcjkb/rustaceanvim"; };
    # musnix = { url = "github:musnix/musnix"; };
  };
  outputs =
    { nixpkgs, home-manager, nixos-hardware, nix-colors, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      include = p: with builtins;
        map (f: "${p}/${f}") (filter (n: !isNull (match ".*+\.nix" n)) (attrNames (readDir p)));
      overlays =
        with inputs; [
          rust-overlay.overlays.default
          nur.overlay
          neovim-nightly-overlay.overlays.default
          (_final: prev: with prev; {
            inherit LS_COLORS;
          })

          (_self: super: {
            dmenu = super.dmenu.overrideAttrs (oldAttrs: rec {
              src = dmenu-flexipatch;
              configFile = super.writeText "config.h" (builtins.readFile ./config/suckless/dmenu-config.h);
              postPatch = ''
                ${oldAttrs.postPatch}
                cp ${configFile} config.h 
              '';
            });

            dwm = super.dwm.overrideAttrs (oldAttrs: rec {
              src = dwm-flexipatch;
              configFile = super.writeText "config.h" (builtins.readFile ./config/suckless/dwm-config.h);
              postPatch = ''
                ${oldAttrs.postPatch}
                cp ${configFile} config.h
              '';
            });

            st = super.st.overrideAttrs (oldAttrs: rec {
              src = st-flexipatch;
              configFile = super.writeText "config.h" (builtins.readFile ./config/suckless/st-config.h);
              postPatch = ''
                ${oldAttrs.postPatch}
                cp ${configFile} config.h 
              '';
            });
          })
          (_final: prev:
            let
              inherit (prev.vimUtils) buildVimPlugin;
            in
            {
              vimPlugins = with inputs;
                prev.vimPlugins
                // {
                  vim-log-highlighting = buildVimPlugin {
                    name = "vim-log-highlighting";
                    src = vim-log-highlighting;
                    meta = { homepage = "https://github.com/MTDL9/vim-log-highlighting"; };
                  };
                  vim-interestingwords = buildVimPlugin {
                    name = "vim-interestingwords";
                    src = vim-interestingwords;
                    meta = { homepage = "https://github.com/lfv89/vim-interestingwords"; };
                  };
                  nvim-lsp-file-operations = buildVimPlugin {
                    name = "nvim-lsp-file-operations";
                    src = nvim-lsp-file-operations;
                    meta = { homepage = "https://github.com/antosha417/nvim-lsp-file-operations"; };
                  };
                  nvim-dap-vscode-js = buildVimPlugin {
                    name = "nvim-dap-vscode-js";
                    src = nvim-dap-vscode-js;
                    meta = { homepage = "https://github.com/mxsdev/nvim-dap-vscode-js"; };
                  };
                  neotest-playwright = buildVimPlugin {
                    name = "neotest-playwright";
                    src = neotest-playwright;
                    meta = { homepage = "https://github.com/thenbe/neotest-playwright"; };
                  };
                  sxhkd-vim = buildVimPlugin {
                    name = "sxhkd-vim";
                    src = sxhkd-vim;
                    meta = { homepage = "https://github.com/kovetskiy/sxhkd-vim"; };
                  };
                  persistent-breakpoints = buildVimPlugin {
                    name = "persistent-breakpoints";
                    src = persistent-breakpoints;
                    meta = { homepage = "https://github.com/Weissle/persistent-breakpoints.nvim"; };
                  };
                };
            })
        ];
      common = {
        imports = [ ]
          ++ include ./config
          ++ include ./config/environment
          ++ include ./config/programs
          ++ include ./config/services
          ++ include ./config/suckless
          ++ include ./config/systemd
          ++ include ./lsp
          ++ include ./sql
        ;
        nixpkgs.overlays = overlays;
        nix.registry = {
          # nixpkgs.flake = inputs.nixpkgs;
          # home-manager.flake = inputs.home-manager;
          os = { to = { type = "git"; url = "file:///etc/nixos"; }; };
        };
      };
      commonHome = {
        home.stateVersion = "23.05";
        colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
        imports = [ nix-colors.homeManagerModules.default ]
          ++ include ./home
          ++ include ./home/programs
          ++ include ./home/services
          ++ include ./plugin
        ;
        home.shellAliases = { };
        home.sessionVariables = {
          BROWSER = "firefox";
          MOZ_X11_EGL = "1";
          # SYSTEM = config.system.name;
        };
        home.file = { };
      };
    in
    {
      formatter."${system}" = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        dell = nixpkgs.lib.nixosSystem {
          # DELL XPS 7590
          inherit system;
          # specialArgs = { };
          modules = [
            {
              environment.systemPackages = with pkgs; [ stylelint ];
              environment.shellAliases = { stylelint = "stylelint -c /etc/nixos/.stylelintrc.json --config-basedir /etc/nixos"; };
            }
            { environment.systemPackages = with pkgs; [ htmx-lsp emmet-ls emmet-language-server ludtwig html-tidy ]; } # html
            { environment.systemPackages = with pkgs; [ vscode-langservers-extracted nodePackages.fixjson ]; } # json
            { environment.systemPackages = with pkgs; [ gnumake checkmake ]; } # make
            { environment.systemPackages = with pkgs; [ marksman mdformat markdownlint-cli markdownlint-cli2 ]; } # markdown
            { environment.systemPackages = with pkgs; [ taplo taplo-cli taplo-lsp ]; } # toml
            { environment.systemPackages = with pkgs; [ vim-vint nodePackages.vim-language-server ]; } # vim
            { environment.systemPackages = with pkgs; [ yaml-language-server ]; } # yaml
            { environment.systemPackages = with pkgs; [ zig zls zig-shell-completions zap ]; } # zig
            {
              environment.systemPackages = with pkgs; [
                pyright
                black
                (python3.withPackages (ps: with ps; [
                  pip
                  # pipx
                  requests
                  pytest
                  pytest-watch
                  pytest-timeout
                  pytest-playwright
                  pynvim
                  livereload
                  debugpy
                  python-dotenv
                  httpie
                ]))
              ];
            }
            {
              environment.systemPackages = with pkgs; [ playwright ];
              environment.sessionVariables = {
                # PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
                PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
                PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
                PLAYWRIGHT_BROWSERS_VERSION = "${pkgs.playwright-driver.version}";
              };
            }

            {
              # rust rust-bin.stable.latest.default
              environment.variables = { LD_LIBRARY_PATH = "${pkgs.lldb.lib}/lib/liblldb.so"; };
              environment.systemPackages = with pkgs; [ cargo cargo-nextest rustc rust-analyzer rustfmt ];
            }
            { environment.systemPackages = with pkgs; [ dotenv-linter shellharden shfmt nodePackages.bash-language-server ]; }
            common
            ./_dell.nix
            ./_audio.nix
            nixos-hardware.nixosModules.dell-xps-15-7590
            nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = commonHome;
                # extraSpecialArgs = { };
              };

            }
          ];
        };

        pc = nixpkgs.lib.nixosSystem {
          # PC B450 AORUS M
          inherit system;
          # specialArgs = { };
          modules = [
            common
            ./_pc.nix
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
            nixos-hardware.nixosModules.common-hidpi
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.root = commonHome;
                # extraSpecialArgs = { };
              };
            }
          ];
        };
      };
    };
}
