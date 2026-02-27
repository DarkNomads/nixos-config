{ config, pkgs, neovim-nixpkgs, ... }: let
  homeDirectory = "/home/darknomads";
in {

  home.username = "darknomads";
  home.homeDirectory = "${homeDirectory}";

  home.packages = (with pkgs; [
    dejavu_fonts
    waybar
    brave
    bitwarden-desktop
    vintagestory
    ripgrep
    gcc
    lua-language-server
    typescript-language-server
    tailwindcss-language-server
    svelte-language-server
    # ruby-lsp
  ]) ++ (with neovim-nixpkgs.legacyPackages.${pkgs.system}; [
    neovim
  ]);

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      PS1='\n\[\033[1;32m\][\[\033]0;\u@\h: \w\007\]\u@\h:\w]\$'
      PS1+='$([ -n "$IN_NIX_SHELL" ] && echo "\[\033[34m\] (dev-shell)\[\033[0m\]")'
      PS1+='\[\033[0m\] '
    '';
  };

  programs.alacritty = {
    enable = true;
    settings.font = {
      size = 20;
      normal = { family = "DejaVu Sans Mono"; style = "Regular"; };
      bold = { family = "DejaVu Sans Mono"; style = "Bold"; };
      italic = { family = "DejaVu Sans Mono"; style = "Italic"; };
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
      key = "${homeDirectory}/.ssh/id_ed25519.pub";
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
      identityFile = "${homeDirectory}/.ssh/id_ed25519";
      identitiesOnly = true;
    };
  };

  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = {
      menu = "wofi --show drun --prompt 'search'";
      modifier = "Mod4";
      output."*".bg = "${homeDirectory}/Pictures/wallpaper-dark.jpg fill";
      terminal = "alacritty";
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
          position = "top";
        }
      ];
    };
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

  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;
}
