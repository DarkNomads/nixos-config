# Building NixOS
To build, run `sudo nixos-rebuild switch`.

# Building Home Manager
If you do not yet have home-manager installed, run `nix-shell -p home-manager --run "home-manager switch --flake ~/etc/nixos"`.

If you already have home-manager, run `home-manager switch --flake /etc/nixos`.
