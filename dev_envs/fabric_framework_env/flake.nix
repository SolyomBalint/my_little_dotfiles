{
  description = "Flake for fabric python framework";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    fabric.url = "github:Fabric-Development/fabric?ref=main";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShells."x86_64-linux".default = pkgs.mkShell {
        packages = [ ];
        # inpustFrom = [  ];
      };
    };
}
