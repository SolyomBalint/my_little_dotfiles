{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim

    # Formatters
    stylua
    black
    isort
    shfmt
    nixfmt-rfc-style

    # LSPs
    lua-language-server
    llvmPackages_19.clang-tools
    neocmakelsp
    pyright
    marksman
    nil

    # Diagnostic tools
    mypy
  ];
}
