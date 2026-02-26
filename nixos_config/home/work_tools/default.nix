{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    zotero
    obsidian

    # PDF viewers
    zathura
    evince

  ];
}
