{
  config,
  pkgs,
  inputs,
  unstable_pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    unstable_pkgs.neovim

    # Formatters
    stylua
    black
    isort
    shfmt
    nixfmt-rfc-style
    unstable_pkgs.nodePackages_latest.prettier

    # LSPs
    lua-language-server
    unstable_pkgs.llvmPackages_latest.clang-tools
    neocmakelsp
    pyright
    marksman
    nixd
    typescript-language-server

    # Diagnostic tools
    mypy

    # Debuggers
    gdb
    python312Packages.debugpy

    # Avante needs this
    gnumake
    nodejs_23
  ];

  # Needed for nix lsp
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
