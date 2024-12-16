{
  config,
  pkgs,
  inputs,
  ...
}:
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
    nixd

    # Diagnostic tools
    mypy

    # Debuggers
    gdb
    python312Packages.debugpy
  ];

  # Needed for nix lsp
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
