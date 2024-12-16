{ username, pkgs, ... }:

{
  # Nixos global configuration for the current user.
  programs.steam.enable = true;
  # programs.steam.gamescopeSession.enable = true;
  #
  # environment.systemPackages = with pkgs; [
  #   mangohud
  # ];
  #
  # programs.gamemode.enable = true;

  # For zen
  services.flatpak.enable = true;
}
