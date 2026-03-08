{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    dejavu_fonts
    nerd-fonts.fira-code
  ];

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = {
      defaultWorkspace = "workspace number 1";
      menu = "wofi --show drun --insensitive --prompt 'search'";
      modifier = "Mod4";
      output = {
        "*".bg = "${config.home.homeDirectory}/Pictures/wallpaper-dark.jpg fill";
        "DP-1" = {
          mode = "2560x1440@144Hz";
          pos = "2560 0";
          scale = "1";
        };
        "DP-2" = {
          mode = "2560x1440@144Hz";
          pos = "0 0";
          scale = "1";
        };
      };
      workspaceOutputAssign = [
        { workspace = "1"; output = "DP-1"; }
        { workspace = "2"; output = "DP-2"; }
      ];
      terminal = "alacritty";
      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];
    };
    extraConfig = ''
      exec_always swaymsg focus output DP-1
      input type:pointer {
        accel_profile flat
        pointer_accel 0.7
      }
    '';
    extraSessionCommands = ''
      export GTK_THEME=Adwaita:dark
    '';
  };

  programs.wofi = {
    enable = true;
    settings = {
      width = 750;
      height = 400;
    };
    style = ''
      window {
        background-color: #282a36;
        font-size: 20px;
        font-family: "DejaVu Sans Mono";
        opacity: 0.85;
      }

      #input, #inner-box, #outer-box {
        background-color: #44475a;
        color: #f8f8f2;
        caret-color: #f8f8f2;
        border: none;
      }

      #input:focus {
        outline: none;
        border: none;
        box-shadow: none;
      }
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "sway/workspaces" ];
        modules-right = [ "pulseaudio" "battery" "clock" ];
        pulseaudio = { format = "  {volume}%"; format-muted = "󰖁"; on-click = "pavucontrol"; };
        battery = { format = " {capacity}%"; };
        clock = { format = "{:%H:%M:%S}"; interval = 1; tooltip = false; };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: 'DejaVu Sans Mono';
        font-size: 14px;
      }

      #waybar {
        background-color: rgba(20, 20, 25, 0.2);
        color: #ffffff;
      }

      #clock, #battery, #pulseaudio {
        padding: 0 10px;
        margin: 0 4px;
      }

      #workspaces button {
        padding: 0 10px;
        color: #808080;
      }

      #workspaces button.focused {
        padding: 0 10px;
        color: #ffffff;
      }

      #workspaces button:hover {
        background: none;
        color: #ffffff;
      }
    '';
  };
}
