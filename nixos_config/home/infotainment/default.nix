{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    signal-desktop
    obsidian
    prismlauncher
    discord
    spotify
  ];
}
