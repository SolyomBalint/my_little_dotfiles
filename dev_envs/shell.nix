{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = with pkgs; [ python3 ];
  inpurtFrom = [ ];
  # shellHook = '''';
}
