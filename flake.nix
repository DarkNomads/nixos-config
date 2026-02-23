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
      nixos = nixpkgs.lib.nixosSystem {
      	inherit pkgs;
        modules = [ ./nixos/configuration.nix ];
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
