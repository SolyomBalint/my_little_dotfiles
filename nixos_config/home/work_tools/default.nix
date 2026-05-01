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

    # PDF viewers
    zathura
    evince

  ];
}
