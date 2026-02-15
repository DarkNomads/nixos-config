{ pkgs, ... }: let
  homeDirectory = "/home/darknomads";
in {

  home.username = "darknomads";
  home.homeDirectory = "${homeDirectory}";

  home.packages = with pkgs; [
    neovim
    bash
  ];

  programs.alacritty = {
    enable = true;
    settings.font.size = 20;
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

  home.stateVersion = "25.11";
}
