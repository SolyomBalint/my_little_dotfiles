{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
        python312Full
        python312Packages.pip
        gcc
        cargo
        zulu17 # java openjdk
  ];
}
