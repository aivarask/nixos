{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE root WITH LOGIN PASSWORD 'root' CREATEDB;
      CREATE DATABASE root;
      GRANT ALL PRIVILEGES ON DATABASE root TO root;
    '';
  };
}
