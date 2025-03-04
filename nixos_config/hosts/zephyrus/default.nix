{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../common_modules/common_system.nix
    ../../common_modules/desktop_envs/gnome.nix
    ../../common_modules/desktop_envs/hyprland.nix
    # ../../common_modules/widget_frameworks/ags.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "balint_nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Adding asusctl and supergfxctl
  environment.systemPackages = with pkgs; [
    pciutils
    asusctl
    clinfo
  ];

  services.supergfxd.enable = true;
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  systemd.services.supergfxd.path = [ pkgs.pciutils ];

  system.stateVersion = "24.11";
}
