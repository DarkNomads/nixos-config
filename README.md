# Building NixOS
To build, run `sudo nixos-rebuild switch --flake ~/.nixos-config`.

# Building Home Manager
If you do not yet have home-manager installed, run `nix-shell -p home-manager --run "home-manager switch --flake ~/.nixos-config"`

If you already have home-manager, run `home-manager switch --flake ~/.nixos-config`.
