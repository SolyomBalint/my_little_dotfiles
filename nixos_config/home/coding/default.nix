{
  config,
  pkgs,
  unstable_pkgs,
  ...
}:
{
  # Packages used by the user globally
  home.packages = with pkgs; [
    # General
    python312Full
    python312Packages.pip
    gcc
    cargo
    zulu17 # java openjdk

    # For damn university
    pkgs.jetbrains.idea-ultimate

    # For development
    unstable_pkgs.devenv
    unstable_pkgs.direnv
    unstable_pkgs.distrobox

    # For raspberry
    unstable_pkgs.rpi-imager

    # For UML/SYSML modelling
    gaphor
  ];
}
