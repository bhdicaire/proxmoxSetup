![proxmoxSetup logo](https://github.com/bhdicaire/proxmoxSetup/raw/main/docs/logo.png)

This is an [ansible](https://www.redhat.com/en/ansible-collaborative) playbook for configuring a [Proxmox Virtual Environment (PVE)](https://www.proxmox.com/en/proxmox-virtual-environment/overview).

PVE is based on [Debian GNU/Linux](https://www.debian.org/) including security updates and bug fixes. PVE use their own Linux kernel based on Ubuntu with several extra hardware drivers, [ZFS](https://zfsonlinux.org/), virtualization, and container features.

## What problem does it solve and why is it useful?

Setup one or several [PVE](https://pve.proxmox.com) with easy-to-understand instructions that automate the installation and configuration from the bare metal.
<details>
<summary>Everything is configured properly</summary>
* Disable the enterprise repo, enable the public repo, and add non-free sources
* Remove subscription banner
</details>

FYI, my [build of material (BoM)](docs/bom.md) use the x86-64 architecture.

## Initial setup

1. Configure BIOS on each machine:
  * Install the latest bios version
  * Reset BIOS to factory defaults
  * Pick UEFI / Secure Boot or legacy, it does not matter
  * Enable virtualization also known as VT-d, SRV-IO, or IOMMU for passthrough via Proxmox
  * Configure power state:
    * Boot on power restore
    * Wake on Lan
2. Download the latest [ISO image](https://www.proxmox.com/en/downloads/proxmox-virtual-environment/iso) 
  * It is a bare-metal installer, please be aware that the complete server is used and existing data on the selected disks will be removed
3. Create an USB install media with [Rufus](https://rufus.ie/en/) or [Balener Etcher](https://etcher.balena.io/)
4. Setup proxmox identically on each node including the root password
  * Boot from proxmox 
  * Use a different hostname and static IP address for each machine
  * Choose XFS for root filesystem
  * Reboot once install finishes
5. Configure SSH
  * Create a SSH public and private key on your favorite computer. 
6. Modify the inventory
  * Edit the ansible `inventory.ini` file for your own nodes.
7. Run the ansible playbook: `ansible-playbook site.yml` 
  * Secure the nodes, removing password authentication
  * Create Proxmox cluster
  * Create Ceph cluster and storage
8. Access the user interface with your web browser: https://192.168.1.168:8006/

## Insights

### `apt update -y;apt dist-upgrade -y`

Never run `apt upgrade` because it might break Proxmox. Run `apt dist-upgrade` instead, as documented in the [Proxmox VE Documentation](https://pve.proxmox.com/pve-docs/index.html). You can also refer to the [Debian Administrator's Handbook](https://debian-handbook.info/get).

## _proxmoxSetup_ by Benoît H. Dicaire is shared with an [MIT license](https://github.com/bhdicaire/macSetup/raw/main/LICENSE).
[Suggestions and improvements](https://github.com/bhdicaire/proxmoxSetup/issues) are welcome!