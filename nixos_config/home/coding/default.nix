{
  config,
  pkgs,
  nixpkgs_stable,
  inputs,
  ...
}:
{
  programs.java.enable = true;
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscode.fhsWithPackages (
  #     ps: with ps; [
  #       gcc
  #       gdb
  #       openssl.dev
  #       pkg-config
  #     ]
  #   );
  # };

  # Packages used by the user globally
  home.packages = with pkgs; [
    # General
    cargo

    # For damn university
    pkgs.jetbrains.idea-ultimate

    # For development
    devenv
    direnv
    distrobox

    # For raspberry
    rpi-imager

    inputs.claude-desktop.packages.${system}.claude-desktop
    # For UML/SYSML modelling
    nixpkgs_stable.gaphor
    drawio
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
  ];
}
