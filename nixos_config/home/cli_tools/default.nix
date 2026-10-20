{
  config,
  pkgs,
  inputs,
  nixpkgs_stable,
  ...
}:
{

  home.packages = with pkgs; [
    fastfetch
    stow
    fd
    yazi
    bat
    delta
    fzf
    bottom
    jq
    dos2unix
    nmap
    gnome-multi-writer
    nettools
    bear
    usbutils
    touying
    parted

    # Music handling
    playerctl

    #AI
    opencode

    poppler-utils

    nixpkgs_stable.python313Packages.markitdown
    docling

    # For handling controller inputs
    evtest
    linuxConsoleTools
  ];
}
