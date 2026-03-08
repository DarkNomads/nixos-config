{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { nixpkgs, home-manager, neovim-nixpkgs, ... }: let
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
        modules = [ ./machines/desktop/configuration.nix ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [ ./machines/laptop/configuration.nix ];
      };
    };

    homeConfigurations = {
      darknomads = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit neovim-nixpkgs; };
        modules = [ ./users/darknomads.nix ];
      };
    };
  };
}
