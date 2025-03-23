{
  config,
  pkgs,
  nixpkgs_stable,
  ...
}:
{
  programs.java.enable = true;
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        gcc
        gdb
        openssl.dev
        pkg-config
      ]
    );
  };

  # Packages used by the user globally
  home.packages = with pkgs; [
    # General
    python312Full
    python312Packages.pip
    gcc
    cargo

    # For damn university
    pkgs.jetbrains.idea-ultimate

    # For development
    devenv
    direnv
    distrobox

    # For raspberry
    rpi-imager

    # For UML/SYSML modelling
    nixpkgs_stable.gaphor
    drawio
  ];
}
