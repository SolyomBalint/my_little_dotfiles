{
  config,
  pkgs,
  unstable_pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    neofetch
    stow
    gdb
    fd
    unstable_pkgs.yazi
    bat
    delta
    fzf
    bottom
    jq

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

    # Useful nix CLI tools
    unstable_pkgs.nix-output-monitor
  ];
}
