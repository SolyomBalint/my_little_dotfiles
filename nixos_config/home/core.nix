{ pkgs, ... }:
{
  # home.username and home.homeDirectory are set per user by home-manager's
  # NixOS module, so this file stays user-agnostic.
  home.stateVersion = "26.05";

  # TODO: Kanagawa gtk theme seems to be unmaintained, check for solutions
  home.packages = with pkgs; [
    # kanagawa-gtk-theme
    # kanagawa-icon-theme
    libreoffice-qt-stable
  ];

  gtk = {
    enable = true;
    colorScheme = "dark";
    # iconTheme = {
    #   name = "Kanagawa";
    #   package = pkgs.kanagawa-icon-theme;
    # };
    # theme = {
    #   name = "Kanagawa";
    #   package = pkgs.kanagawa-gtk-theme;
    # };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  programs.home-manager.enable = true;
}
