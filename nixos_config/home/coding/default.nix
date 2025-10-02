{
  config,
  pkgs,
  nixpkgs_stable,
  inputs,
  ...
}:
{
  programs.java.enable = true;

  # Packages used by the user globally
  home.packages = with pkgs; [
    # General
    cargo
    zed-editor-fhs
    vscode-fhs

    # For damn university
    # pkgs.jetbrains.idea-ultimate

    inputs.claude-desktop.packages.${system}.claude-desktop-with-fhs

    # For development
    devenv
    direnv
    # distrobox
    unityhub

    # For raspberry
    rpi-imager

    # For UML/SYSML modelling
    nixpkgs_stable.gaphor
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
