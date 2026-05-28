{
  lib,
  pkgs,
  ...
}:

{
  # could be useful for finding gpu cards, but not needed rn
  # services.udev.extraRules =
  #   let
  #     amdIgpuId = builtins.readFile (
  #       pkgs.runCommand "get-amd-igpu-id"
  #         {
  #           buildInputs = [ pkgs.pciutils ];
  #         }
  #         ''
  #           lspci -d ::03xx | grep 'Radeon 680' | cut -f1 -d' ' | tr -d '\n' > $out
  #         ''
  #     );
  #   in
  #   ''
  #     KERNEL=="card*", KERNELS=="0000:${amdIgpuId}", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/amd-igpu"
  #   '';

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [
    amdgpu_top
    vulkan-tools
    clinfo
    gpu-viewer
    dxvk_2
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
    legacySupport.enable = true;
  };
}
