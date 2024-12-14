{
  pkgs,
  lib,
  username,
  ...
}:
{
  services.xserver = {
    desktopManager.gnome.enable = true;
  };

}
