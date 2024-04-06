{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-test
    neotest
    neotest-bash
    neotest-go
    neotest-jest
    neotest-phpunit
    neotest-pest
    neotest-playwright
    neotest-plenary
    neotest-python
    neotest-rust
    neotest-zig
    neotest-vitest
  ];
}
