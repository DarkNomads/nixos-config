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

  systemd.user.services.protonvpn-gui = {
    Unit = {
      Description = "ProtonVPN GUI";
      After = [ "network-online.target" "graphical-session.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.protonvpn-gui}/bin/protonvpn-app --start-minimized";
      Restart = "always";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
