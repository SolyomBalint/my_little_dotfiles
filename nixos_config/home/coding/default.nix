{
  config,
  pkgs,
  unstable_pkgs,
  ...
}:
{
  # Packages used by the user globally
  home.packages = with pkgs; [
    python312Full
    python312Packages.pip
    gcc
    cargo
    zulu17 # java openjdk

    # For damn university
    pkgs.jetbrains.idea-ultimate

    unstable_pkgs.devenv
    unstable_pkgs.direnv
    unstable_pkgs.distrobox
  ];
}
