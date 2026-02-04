{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    zotero
    obsidian
    anki

    # PDF viewers
    zathura
    evince

  ];
}
