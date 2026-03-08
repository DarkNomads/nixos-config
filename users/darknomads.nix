{ config, pkgs, ... }:

{

  imports = [
    ./common.nix
    ./modules/wayland.nix
    ./modules/neovim.nix
  ];

  home.packages = with pkgs; [
    brave
    protonvpn-gui
    bitwarden-desktop
    discord
    ytmdesktop
    vintagestory
    reaper
    qmk
  ];
}
