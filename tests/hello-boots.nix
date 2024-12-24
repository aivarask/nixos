{ self, pkgs }:

pkgs.nixosTest {
  name = "hello-boots";
  nodes.machine =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.helloNixosModule
      ];
      services.helloNixosTests = {
        enable = true;
      };

      system.stateVersion = "23.11";
    };

  testScript = ''
    machine.wait_for_unit("helloNixosTests.service")
    machine.wait_for_open_port(3000)
  '';
}
