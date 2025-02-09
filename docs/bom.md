My build of material (BoM) used the x86-64 architecture.

https://github.com/bhdicaire/macSetup/blob/master/doc/install.md) with an Ansible playbook.

The Software Build of Material (SBoM) is documented [here](https://github.com/bhdicaire/macSetup/blob/master/doc/sbom.md).

This is a minimal [proxmox](https://pve.proxmox.com) setup based on an x86-64 architecture.

## Hosts description

This is a minimal [proxmox](https://pve.proxmox.com) setup based on an x86-64 architecture. It should use more disks and nodes. This setup can survive if one of the nodes dies as long you're doing backups.

**PVE01.local**
 * [ASRock Industrial NUC BOX-155H](https://www.asrockind.com/en-gb/NUC%20BOX-155H)
   * INtel 4 core i7 processor (8 vCPUs)
   * 96GB RAM
   * 1TB m.2 SSD `nvme0n1` for boot device
   * 2TB SATA SSD `/dev/sda` for Ceph OSD (distributed/clustered storage).
   * Onboard 1GbE network adapter `eno1` for the public internet route and management device, IP is `192.168.3.0/24`
   * A USB ethernet network adapter `enxAAAAAAAAAAAA`  for the private ceph network, IP is `10.10.10.0/24`

**PVE02.local**
 * ASRock XXYZ
   * INtel 4 core i7 processor (8 vCPUs)
   * 32GB RAM
   * 1TB m.2 SSD `nvme0n1` for boot device
   * 2TB SATA SSD `/dev/sda` for Ceph OSD (distributed/clustered storage).
   * Onboard 1GbE network adapter `eno1` for the public internet route and management device, IP is `192.168.3.0/24`
   * A USB ethernet network adapter `enxAAAAAAAAAAAA`  for the private ceph network, IP is `10.10.10.0/24` 

HP 260 G2 Desktop Mini PC / Debian 12.8

Intel CPU i5-6200U 2.30ghz
RAM 8192 MB DDR4 / 2133 MHZ / Dual Channel <- **Max ram: 32 GB**
Adata SU630 SSD 240GB
Firmware: 04/26/2017
HDMI + DVI connector
https://support.hp.com/id-en/drivers/hp-260-g2-desktop-mini-pc/10049306