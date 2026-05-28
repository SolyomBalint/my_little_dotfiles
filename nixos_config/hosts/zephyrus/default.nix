{ ... }:

{
  imports = [
    ../../common_modules/common_system.nix
    ../../common_modules/desktop_envs/gnome.nix
    ../../common_modules/desktop_envs/hyprland.nix

    ./hardware-configuration.nix
    ./hardware.nix
    ./host.nix
  ];
}
