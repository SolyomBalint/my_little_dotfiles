{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
        python312Full
        python312Packages.pip
        gcc
        cargo
  ];
}
