{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      inherit system;
      desktop = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/desktop/configuration.nix ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [ ./hosts/laptop/configuration.nix ];
      };
    };

    homeConfigurations = {
      darknomads = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/darknomads.nix ];
      };
    };
  };
}
