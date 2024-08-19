{ include, ... }:
{
  imports = [ ]
    ++ include ./config
    ++ include ./config/environment
    ++ include ./config/programs
    ++ include ./config/services
    ++ include ./config/suckless
    ++ include ./config/systemd
    ++ include ./dsl
    ++ include ./sql
  ;
}
