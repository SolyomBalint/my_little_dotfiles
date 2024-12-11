{ username, pkgs, ... }:
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    kanagawa-gtk-theme
    kanagawa-icon-theme
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-icon-theme;
    };
    theme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-gtk-theme;
    };
  };

  programs.home-manager.enable = true;
}
