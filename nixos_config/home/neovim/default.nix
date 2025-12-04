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
    prettier
    typstyle

    # LSPs
    lua-language-server
    # llvmPackages_latest.clang-tools
    neocmakelsp
    pyright
    marksman
    nixd
    typescript-language-server
    glsl_analyzer
    tinymist

    # Diagnostic tools
    mypy

    # Debuggers
    gdb
    python312Packages.debugpy

    gcc15

    # Avante needs this
    gnumake
    nodejs_24

    # document generation
    typst
    texliveFull
  ];

  # Needed for nix lsp
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}
