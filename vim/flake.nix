{
  description = "Vim flake";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nvim-tree-lua = {
      url = "github:nvim-tree/nvim-tree.lua";
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
    neotest = {
      url = "github:aivarask/neotest";
      flake = false;
    };
    neotest-playwright = {
      # url = "github:thenbe/neotest-playwright";
      url = "github:aivarask/neotest-playwright";
      flake = false;
    };
    neotest-vitest = {
      url = "github:marilari88/neotest-vitest";
      # url = "github:aivarask/neotest-vitest";
      flake = false;
    };
    neotest-plenary = {
      url = "github:nvim-neotest/neotest-plenary";
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
    nvim-lspconfig.url = "github:neovim/nvim-lspconfig";
    # LSP
    nvim-lsp-file-operations = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };
    which-key-nvim = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    emmet-ls = {
      url = "github:aca/emmet-ls";
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
    vim-log-highlighting = {
      url = "github:MTDL9/vim-log-highlighting";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: {
    # packages.x86_64-linux.default = "vimFlake";
    overlays.default = final: prev: let
      inherit (prev.vimUtils) buildVimPlugin;
    in {
      vimPlugins =
        prev.vimPlugins
        // {
          vim-log-highlighting = buildVimPlugin {
            name = "vim-log-highlighting";
            src = inputs.vim-log-highlighting;
          };

          nvim-tree-lua = buildVimPlugin {
            name = "nvim-tree-lua";
            src = inputs.nvim-tree-lua;
          };

          pretty-fold = buildVimPlugin {
            name = "pretty-fold";
            src = inputs.pretty-fold;
          };
          fold-preview = buildVimPlugin {
            name = "fold-preview";
            src = inputs.fold-preview;
          };
          neotest = buildVimPlugin {
            name = "neotest";
            src = inputs.neotest;
          };
          neotest-playwright = buildVimPlugin {
            name = "neotest-playwright";
            src = inputs.neotest-playwright;
          };
          neotest-vim-test = buildVimPlugin {
            name = "neotest-vim-test";
            src = inputs.neotest-vim-test;
          };
          neotest-vitest = buildVimPlugin {
            name = "neotest-vitest";
            src = inputs.neotest-vitest;
          };
          neotest-plenary = buildVimPlugin {
            name = "neotest-plenary";
            src = inputs.neotest-plenary;
          };
          refactoring-nvim = buildVimPlugin {
            name = "refactoring-nvim";
            src = inputs.refactoring-nvim;
          };
          vim-interestingwords = buildVimPlugin {
            name = "vim-interestingwords";
            src = inputs.vim-interestingwords;
          };
          nvim-lspconfig = buildVimPlugin {
            name = "nvim-lspconfig";
            src = inputs.nvim-lspconfig;
          };
          nvim-lsp-file-operations = buildVimPlugin {
            name = "nvim-lsp-file-operations";
            src = inputs.nvim-lsp-file-operations;
          };
          which-key-nvim = buildVimPlugin {
            name = "which-key-nvim";
            src = inputs.which-key-nvim;
          };
          # Session management
          persistence-nvim = buildVimPlugin {
            name = "persistence-nvim";
            src = inputs.persistence-nvim;
          };
          neovim-session-manager = buildVimPlugin {
            name = "neovim-session-manager";
            src = inputs.neovim-session-manager;
          };
          # DEBUGGING
          nvim-dap-vscode-js = buildVimPlugin {
            name = "nvim-dap-vscode-js";
            src = inputs.nvim-dap-vscode-js;
          };
          osv = buildVimPlugin {
            name = "osv";
            src = inputs.osv;
          };
        };
    };
  };
}
