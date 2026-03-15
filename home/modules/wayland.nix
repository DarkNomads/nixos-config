{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    wofi
    pavucontrol
    wl-clipboard
    grim
    slurp
    nerd-fonts.fira-code
  ];

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = null;
    extraConfig = builtins.readFile ../dotfiles/sway/config + ''
      workspace "1" output "DP-1"
      workspace "2" output "DP-2"
      exec_always swaymsg focus output DP-1

      output "*" {
        bg ${config.home.homeDirectory}/Pictures/wallpaper-dark.jpg fill
      }

      output "DP-1" {
        mode 2560x1440@144Hz
        pos 2560 0
        scale 1
      }

      output "DP-2" {
        mode 2560x1440@144Hz
        pos 0 0
        scale 1
      }
    '';
  };

  programs.bash.bashrcExtra = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway --unsupported-gpu
    fi
  '';

  xdg.configFile."waybar/style.css".source = ../dotfiles/waybar/style.css;
  xdg.configFile."waybar/config".source = ../dotfiles/waybar/config.json;
  xdg.configFile."wofi".source = ../dotfiles/wofi;

  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.file.".local/share/applications/steam.desktop".text = ''
    [Desktop Entry]
    Name=Steam
    Exec=env WAYLAND_DISPLAY=$WAYLAND_DISPLAY SWAYSOCK=$SWAYSOCK XDG_SESSION_TYPE=$XDG_SESSION_TYPE steam
    Terminal=false
    Type=Application
  '';
}
