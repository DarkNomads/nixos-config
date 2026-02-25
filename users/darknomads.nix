{ pkgs, neovim-nixpkgs, ... }: let
  homeDirectory = "/home/darknomads";
in {

  home.username = "darknomads";
  home.homeDirectory = "${homeDirectory}";

  home.packages = (with pkgs; [
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
