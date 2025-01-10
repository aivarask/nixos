# vim: nofoldenable
{
  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    vim-log-highlighting = {
      url = "github:MTDL9/vim-log-highlighting";
      flake = false;
    };
    vim-interestingwords = {
      url = "github:lfv89/vim-interestingwords";
      flake = false;
    };
    nvim-lsp-file-operations = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };
    neotest-playwright = {
      url = "github:thenbe/neotest-playwright";
      flake = false;
    };
    persistent-breakpoints = {
      url = "github:Weissle/persistent-breakpoints.nvim";
      flake = false;
    };
    smart-semicolon = {
      url = "github:iagotito/smart-semicolon.nvim";
      flake = false;
    };
    one-small-step-for-vimkind = {
      url = "github:jbyuki/one-small-step-for-vimkind";
      flake = false;
    };
    tree-sitter-language-injection = {
      url = "github:DariusCorvus/tree-sitter-language-injection.nvim";
      flake = false;
    };
    plugins.url = "./plugins";
  };
  outputs =
    { self, ... }@inputs:
    {
      overlays.default = (
        _: prev:
        let
          inherit (prev.vimUtils) buildVimPlugin;
        in
        {
          vimPlugins =
            with inputs;
            prev.vimPlugins
            // {
              one-small-step-for-vimkind = buildVimPlugin {
                name = "one-small-step-for-vimkind";
                src = one-small-step-for-vimkind;
                meta = {
                  homepage = "https://github.com/jbyuki/one-small-step-for-vimkind";
                };
              };
              vim-log-highlighting = buildVimPlugin {
                name = "vim-log-highlighting";
                src = vim-log-highlighting;
                meta = {
                  homepage = "https://github.com/MTDL9/vim-log-highlighting";
                };
              };
              vim-interestingwords = buildVimPlugin {
                name = "vim-interestingwords";
                src = vim-interestingwords;
                meta = {
                  homepage = "https://github.com/lfv89/vim-interestingwords";
                };
              };
              nvim-lsp-file-operations = buildVimPlugin {
                name = "nvim-lsp-file-operations";
                src = nvim-lsp-file-operations;
                meta = {
                  homepage = "https://github.com/antosha417/nvim-lsp-file-operations";
                };
                doCheck = false;
              };
              neotest-playwright = buildVimPlugin {
                name = "neotest-playwright";
                src = neotest-playwright;
                meta = {
                  homepage = "https://github.com/thenbe/neotest-playwright";
                };
                doCheck = false;
              };
              persistent-breakpoints = buildVimPlugin {
                name = "persistent-breakpoints";
                src = persistent-breakpoints;
                meta = {
                  homepage = "https://github.com/Weissle/persistent-breakpoints.nvim";
                };
                doCheck = false;
              };
              smart-semicolon = buildVimPlugin {
                name = "smart-semicolon";
                src = smart-semicolon;
                meta = {
                  homepage = "https://github.com/iagotito/smart-semicolon.nvim";
                };
              };
              tree-sitter-language-injection = buildVimPlugin {
                name = "tree-sitter-language-injection";
                src = tree-sitter-language-injection;
                meta = {
                  homepage = "https://github.com/DariusCorvus/tree-sitter-language-injection.nvim";
                };
              };
            };
        }
      );
      nixosModules = {
        plugins = inputs.plugins.nixosModules;
        default =
          { ... }:
          {
            nixpkgs.overlays = [
              inputs.neovim-nightly-overlay.overlays.default
              self.overlays.default
            ];
          };
        home =
          { pkgs, ... }:
          {
            programs.neovim.plugins = (
              with pkgs.vimPlugins;
              [
                vim-log-highlighting
                vim-interestingwords
                one-small-step-for-vimkind
                nvim-lsp-file-operations
                neotest-playwright
                persistent-breakpoints
                smart-semicolon
                tree-sitter-language-injection
              ]
            );
          };
      };
    };
}
