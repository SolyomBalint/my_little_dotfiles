{ ... }:

{
  imports = [
    ../../common_modules/common_system.nix
    ../../common_modules/desktop_envs/gnome.nix

    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  system.stateVersion = "24.11";
}
