# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, nixpkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
  ];

  environment.systemPackages = with pkgs; [
    nvidia-offload
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "kvm-intel" ];
  nixpkgs.config.allowUnfree = true;
  boot.extraModulePackages = [
    config.boot.kernelPackages.nvidia_x11
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/aca573c6-9c30-4125-8d0c-0241c410f560";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/5E3C-4C52";
    fsType = "vfat";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp60s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;
  hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.screenSection = ''
      Option "nvidiaXineramaInfoOrder" "DP-1"
      Option "metamodes" "DP-1: nvidia-auto-detect, HDMI-0: nvidia-auto-detect"
  '';

  hardware.nvidia.powerManagement.enable = false;

  hardware.nvidia = {
    modesetting.enable = true;
    prime = {
      sync.enable = true; # gpu always
      offload.enable = false; # gpu on demand
      #nvidiaBusId = "PCI:10:0:0"; #epgu
      nvidiaBusId = "PCI:1:0:0"; # dedicated gpu
      intelBusId = "PCI:0:2:0";
    };
  };
}
