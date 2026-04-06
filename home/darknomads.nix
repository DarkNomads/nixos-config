{ config, pkgs, ... }:

{

  imports = [
    ./modules/common.nix
    ./modules/neovim.nix
    ./modules/wayland.nix
  ];

  home.packages = with pkgs; [
    brave
    proton-vpn
    bitwarden-desktop
    discord
    ytmdesktop
    vintagestory
    reaper
    obs-studio
    libreoffice-still
  ];

  systemd.user.services.proton-vpn = {
    Unit = {
      Description = "ProtonVPN";
      After = [ "network-online.target" "graphical-session.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.proton-vpn}/bin/protonvpn-app --start-minimized";
      Restart = "always";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
