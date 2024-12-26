{ self, pkgs }:

pkgs.nixosTest {
  name = "hello-boots";
  nodes.machine =
    { ... }:
    {
      system.stateVersion = "23.11";
      imports = [
        self.nixosModules.helloNixosModule
      ];
      services.helloNixosTests = {
        enable = true;
      };

    };

  testScript = ''
    machine.wait_for_unit("helloNixosTests.service")
    machine.wait_for_open_port(3000)
  '';
}
