{ nixvirt }:
{

  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.verbose = true;
  virtualisation.libvirt.swtpm.enable = true;
  virtualisation.libvirt.connections."qemu:///session".pools = [
    {
      active = true;
      definition = nixvirt.lib.pool.writeXML {
        name = "MyPool";
        uuid = "650c5bbb-eebd-4cea-8a2f-36e1a75a8683";
        type = "dir";
        target = {
          path = "/root/VM-Storage/MyPool";
        };
      };
      volumes = [
        {
          present = true;
          name = "MainDisk";
          capacity = {
            count = 10;
            unit = "GB";
          };
        }
      ];

    }
  ];
  virtualisation.libvirt.connections."qemu:///session".domains = [
    {
      active = true;
      definition = nixvirt.lib.domain.writeXML (
        nixvirt.lib.domain.templates.linux {
          name = "Penguin";
          uuid = "cc7439ed-36af-4696-a6f2-1f0c4474d87e";
          memory = {
            count = 6;
            unit = "GiB";
          };
          storage_vol = {
            pool = "MyPool";
            # qemu-img create -f qcow2 foobar.qcow2 100M
            volume = "MainDisk";
          };
        }
      );

    }
  ];

}
