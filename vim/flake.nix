{
  description = "Vim flake";
  inputs = {
    vim-log-highlighting = {
      url = "github:MTDL9/vim-log-highlighting";
      flake = false;
    };
    pretty-fold = {
      url = "github:anuvyklack/pretty-fold.nvim";
      flake = false;
    };
    fold-preview = {
      url = "github:anuvyklack/fold-preview.nvim";
      flake = false;
    };
    # NEOTEST
    neotest-vim-test = {
      url = "github:nvim-neotest/neotest-vim-test";
      flake = false;
    };
    neotest-playwright = {
      url = "github:thenbe/neotest-playwright";
      # url = "github:aivarask/neotest-playwright";
      flake = false;
    };
    refactoring-nvim = {
      url = "github:ThePrimeagen/refactoring.nvim";
      flake = false;
    };
    vim-interestingwords = {
      url = "github:lfv89/vim-interestingwords";
      flake = false;
    };
    # LSP
    nvim-lsp-file-operations = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };
    # Session
    persistence-nvim = {
      url = "github:folke/persistence.nvim";
      flake = false;
    };
    neovim-session-manager = {
      url = "github:Shatur/neovim-session-manager";
      flake = false;
    };
    # DEBUGGING
    nvim-dap-vscode-js = {
      url = "github:mxsdev/nvim-dap-vscode-js";
      flake = false;
    };
    osv = {
      url = "github:jbyuki/one-small-step-for-vimkind";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs: {
      # packages.x86_64-linux.default = "vimFlake";
      overlays.default = final: prev:
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
              };
              pretty-fold = buildVimPlugin {
                name = "pretty-fold";
                src = pretty-fold;
              };
              fold-preview = buildVimPlugin {
                name = "fold-preview";
                src = fold-preview;
              };
              neotest-playwright = buildVimPlugin {
                name = "neotest-playwright";
                src = neotest-playwright;
              };
              neotest-vim-test = buildVimPlugin {
                name = "neotest-vim-test";
                src = neotest-vim-test;
              };
              refactoring-nvim = buildVimPlugin {
                name = "refactoring-nvim";
                src = refactoring-nvim;
              };
              vim-interestingwords = buildVimPlugin {
                name = "vim-interestingwords";
                src = vim-interestingwords;
              };
              nvim-lsp-file-operations = buildVimPlugin {
                name = "nvim-lsp-file-operations";
                src = nvim-lsp-file-operations;
              };
              # Session management
              persistence-nvim = buildVimPlugin {
                name = "persistence-nvim";
                src = persistence-nvim;
              };
              neovim-session-manager = buildVimPlugin {
                name = "neovim-session-manager";
                src = neovim-session-manager;
              };
              # DEBUGGING
              nvim-dap-vscode-js = buildVimPlugin {
                name = "nvim-dap-vscode-js";
                src = nvim-dap-vscode-js;
              };
              osv = buildVimPlugin {
                name = "osv";
                src = osv;
              };
            };
        };
    };
}
