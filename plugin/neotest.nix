{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    neotest
    neotest-bash
    neotest-go
    neotest-jest
    neotest-phpunit
    neotest-playwright
    neotest-plenary
    neotest-python
    neotest-rust
    neotest-zig
    neotest-vitest
  ];
}
