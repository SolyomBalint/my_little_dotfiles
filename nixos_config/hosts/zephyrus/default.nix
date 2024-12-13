{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ../../common_modules/common_system.nix
    ../../common_modules/desktop_envs/gnome.nix
    ../../common_modules/desktop_envs/hyprland.nix

    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "balint_nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Adding asusctl and supergfxctl
  environment.systemPackages = with pkgs; [
    pciutils
    supergfxctl
    asusctl
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
