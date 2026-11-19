{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages;

    kernelModules = [
      "msr"
      "uinput"
      "dummy"
      "wireguard"
    ];

    initrd.systemd.enable = true;
  };

}
