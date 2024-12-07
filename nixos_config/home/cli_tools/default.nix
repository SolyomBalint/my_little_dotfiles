{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    stow
    gdb
    fd
    yazi
    bat
    delta
    fzf
    bottom

    # For sensors
    pciutils
    gtop # similiar to bottom
    amdgpu_top
  ];
}
