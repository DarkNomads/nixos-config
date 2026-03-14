{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;
  home.username = "darknomads";
  home.homeDirectory = "/home/darknomads";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alacritty
    tmux
    dejavu_fonts
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      PS1='\n\[\033[1;32m\][\[\033]0;\u@\h: \w\007\]\u@\h:\w]\$'
      PS1+='$([ -n "$IN_NIX_SHELL" ] && echo "\[\033[34m\] (dev-shell)\[\033[0m\]")'
      PS1+='\[\033[0m\] '

      alias v=nvim
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

  xdg.configFile."alacritty".source = ../dotfiles/alacritty;
  xdg.configFile."tmux".source = ../dotfiles/tmux;
}
