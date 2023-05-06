_: {
  networking.hosts = {
    "192.168.1.1" = ["hw.local"];
    # "88.80.28.163" = ["linkomanija.net"];
    # --
    "127.0.0.1" = ["live.fixasparts.com"];
    "192.168.1.110" = ["pcl"];
    "192.168.1.111" = ["pc"];
    "192.168.1.120" = ["dell"];
    "188.69.243.169" = [
    ];
    "195.181.244.248" = ["q0nr.l.dedikuoti.lt" "fixas" "new.fixasparts.com"];
  };
  networking.extraHosts = ''
    127.0.0.2 other-localhost
    10.0.0.1 server
    # 88.80.28.163 linkomanija.net
    127.0.0.1 live.fixasparts.com
    127.0.0.1 test.com
  '';
}
