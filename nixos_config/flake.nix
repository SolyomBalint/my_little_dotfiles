{
  description = "Global Entry Flake";

  inputs = {
    # Base package repository
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixpkgs_stable = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager";

      # Adding inheritance relation to avoid conflicts in for different nix packages
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi.url = "github:sxyazi/yazi";

    # The flake is faulty atm
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.systems.follows = "systems";

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    ## Quickshell based desktop env
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixpkgs_stable,
      ...
    }:
    {
      nixosConfigurations = {
        balintnixos =
          let
            username = "balintsolyom";
          in

          nixpkgs.lib.nixosSystem rec {
            specialArgs = {
              inherit username;
              inherit inputs;
              nixpkgs_stable = import nixpkgs_stable {
                localSystem = "x86_64-linux";
                config.allowUnfree = true;
                overlays = [
                ];
              };
            };
            modules = [
              ./hosts/zephyrus
              ./users/${username}/nixos.nix

              # Make home manager a NixOs module so it will always load
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
            ];
          };
      };
    };
}
