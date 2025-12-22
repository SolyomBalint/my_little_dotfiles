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
    nixpkgs_stable.jetbrains.idea

    # For development
    devenv
    direnv
    # distrobox

    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop-with-fhs

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
