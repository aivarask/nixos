https://github.com/NixOS/nixpkgs/blob/nixos-22.05/nixos/modules/services/databases/mysql.nix
https://www.tecmint.com/fix-error-1130-hy000-host-not-allowed-to-connect-mysql/
https://mariadb.com/kb/en/grant/

GRANT ALL ON database_name.\* to 'database_username'@'10.24.96.%' IDENTIFIED BY 'database_password';
