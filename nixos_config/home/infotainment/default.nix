{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    signal-desktop
    obsidian
    prismlauncher
    discord
  ];

}