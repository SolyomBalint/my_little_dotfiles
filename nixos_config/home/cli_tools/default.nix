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

    # PDF viewers
    zathura
    evince

    # ePUB viewers
    calibre

    # Music handling
    playerctl

    # For sensors
    # pciutils
    # gtop # similiar to bottom
    # amdgpu_top
  ];
}
