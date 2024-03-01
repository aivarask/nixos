{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    neotest
    neotest-go
    neotest-phpunit
    neotest-playwright
    neotest-plenary
    neotest-python
    neotest-rust
    neotest-zig
  ];
}
