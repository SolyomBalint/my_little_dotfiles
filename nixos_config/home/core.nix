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
    # colorScheme also sets gtk-application-prefer-dark-theme and the dconf
    # org/gnome/desktop/interface color-scheme, so nothing else is needed here
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    # Leaving style.package unset lets home-manager install both adwaita-qt
    # (Qt5) and adwaita-qt6; pinning adwaita-qt left Qt6 apps unstyled
    style.name = "adwaita-dark";
  };

  programs.home-manager.enable = true;
}
