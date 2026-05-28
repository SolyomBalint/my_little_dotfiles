{ pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "balint_nixos";

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  environment.systemPackages = with pkgs; [
    pciutils
  ];

  services.supergfxd = {
    enable = true;

    settings = {
      mode = "Hybrid";
      vfio_enable = false;
      vfio_save = false;
      always_reboot = false;
      no_logind = true;
      logout_timeout_s = 180;
      hotplug_type = "None";
    };
  };

  services.asusd.enable = true;

  system.stateVersion = "26.05";
}
