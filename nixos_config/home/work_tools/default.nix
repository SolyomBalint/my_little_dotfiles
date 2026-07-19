{
  inputs,
  pkgs,
  nixpkgs_stable,
  ...
}:
{
  home.packages = with pkgs; [
    zotero
    obsidian
    nixpkgs_stable.mcp-nixos
    rpi-imager
    tigervnc

    # PDF viewers
    zathura
    evince
    anki
    mcaselector

  ];
}
