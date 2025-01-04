machine.start()
machine.wait_for_unit("default.target")
machine.succeed("which zsh")
