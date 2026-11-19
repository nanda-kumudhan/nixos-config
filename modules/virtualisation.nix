{ pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;
    podman.enable = true;
    docker.enable = true;

    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };

    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    distrobox
    docker-compose
    podman-desktop
    qemu
    spice-gtk

    k9s
    kind
    kustomize
    kubectl
    kubectx
    kubernetes-helm
    minikube
  ];
}
