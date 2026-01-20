machine.start()
machine.wait_for_unit("default.target")
if not "Linux" in machine.succeed("uname"):
    raise Exception("Wrong OS")
