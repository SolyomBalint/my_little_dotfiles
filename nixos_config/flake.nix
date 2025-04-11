{
  description = "Global Entry Flake";

  inputs = {
    # Base package repository
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixpkgs_stable = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager";

      # Adding inheritance relation to avoid conflicts in for different nix packages
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # For claude desktop
    flake-utils.url = "github:numtide/flake-utils";
    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    yazi.url = "github:sxyazi/yazi";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixpkgs_stable,
      ...
    }:
    let
      system = "x86_64-linux";
    in
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
              inherit system;
              nixpkgs_stable = import nixpkgs_stable {
                system = system;
                config.allowUnfree = true;
                overlays = [
                  inputs.hyprpanel.overlay
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
