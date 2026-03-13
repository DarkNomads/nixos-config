{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;
  home.username = "darknomads";
  home.homeDirectory = "/home/darknomads";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    dejavu_fonts
    pavucontrol
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 15;
        normal = { family = "DejaVu Sans Mono"; style = "Regular"; };
        bold = { family = "DejaVu Sans Mono"; style = "Bold"; };
        italic = { family = "DejaVu Sans Mono"; style = "Italic"; };
      };
      colors = {
        primary = { background = "#1f1f28"; foreground = "#dcd7ba"; };
        normal = {
          black = "#090618";
          red = "#c34043";
          green = "#76946a";
          yellow = "#c0a36e";
          blue = "#7e9cd8";
          magenta = "#957fb8";
          cyan = "#6a9589";
          white = "#c8c093";
        };

        bright = {
          black = "#727169";
          red = "#e82424";
          green = "#98bb6c";
          yellow = "#e6c384";
          blue = "#7fb4ca";
          magenta = "#938aa9";
          cyan = "#7aa89f";
          white = "#dcd7ba";
        };

        selection = { background = "#2d4f67"; foreground = "#c8c093"; };
        indexed_colors = [
          { index = 16; color = "#ffa066"; }
          { index = 17; color =  "#ff5d62"; }
        ];
      };
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g terminal-overrides 'xterm-256color:Tc'
      set -g escape-time 0
      set -g history-limit 50000

      set -g status-bg '#1f1f28'
      set -g status-fg blue
      set-option -g status-right '''

      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway --unsupported-gpu
      fi

      PS1='\n\[\033[1;32m\][\[\033]0;\u@\h: \w\007\]\u@\h:\w]\$'
      PS1+='$([ -n "$IN_NIX_SHELL" ] && echo "\[\033[34m\] (dev-shell)\[\033[0m\]")'
      PS1+='\[\033[0m\] '
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "ghostnomadjr@gmail.com";
        name = "DarkNomads";
      };
      gpg.format = "ssh";
    };
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
    };
  };

  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "1h";
      identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
      identitiesOnly = true;
    };
  };

  home.file.".local/share/applications/steam.desktop".text = ''
    [Desktop Entry]
    Name=Steam
    Exec=env WAYLAND_DISPLAY=$WAYLAND_DISPLAY SWAYSOCK=$SWAYSOCK XDG_SESSION_TYPE=$XDG_SESSION_TYPE steam
    Terminal=false
    Type=Application
  '';

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
