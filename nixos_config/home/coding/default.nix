{
  config,
  pkgs,
  nixpkgs_stable,
  inputs,
  ...
}:
let
  rstudio_with_packages = pkgs.rstudioWrapper.override {
    packages = with pkgs.rPackages; [
      car
      lmtest
      tidyverse
      forecast
    ];
  };
in
{
  programs.java.enable = true;

  # Packages used by the user globally
  home.packages = with pkgs; [
    # General
    cargo
    zed-editor-fhs
    vscode-fhs
    nixpkgs_stable.jetbrains.idea-ultimate
    rstudio_with_packages
    R

    # For development
    devenv
    direnv
    # distrobox
    unityhub

    # For raspberry
    #TODO latest cmake broke this package
    # rpi-imager

    # For UML/SYSML modelling
    nixpkgs_stable.gaphor

    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs
    # drawio

    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
            # lacking many basic packages needed by most software.
            # Therefore, we need to add them manually.
            #
            # pkgs.appimageTools provides basic packages required by most software.
            (base.targetPkgs pkgs)
            ++ (with pkgs; [
              pkg-config
              python313Packages.python
              python313Packages.pip
              python313Packages.virtualenv
              # Feel free to add more packages here if needed.
            ]);
          profile = "export FHS=1";
          runScript = "zsh";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
    # GTK UI design
    # glade
  ];
}
