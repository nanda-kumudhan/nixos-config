{ pkgs, ... }:

{
  networking = {
    hostName = "forge";
    firewall.enable = false;

    # Podman and libvirt use nftables for their virtual networks.
    nftables.enable = true;

    networkmanager = {
      enable = true;
      wifi = {
        macAddress = "permanent";
        scanRandMacAddress = false;
      };
      ethernet.macAddress = "permanent";
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };
  };
}
