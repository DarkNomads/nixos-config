{ config, pkgs, ... }: let
  nvimDir = ../dotfiles/nvim;
in
{
  home.packages = with pkgs; [
    neovim
    ripgrep
    tree-sitter
    gcc
    lua-language-server
    typescript-language-server
  ];

  # Symlink all individual files so Neovim can still create a lockfile at ~/.config/nvim.
  # This is the equivalent of running the following, without making the directory readonly:
  # xdg.configFile."nvim".source = ../dotfiles/nvim;
  xdg.configFile = builtins.listToAttrs (
    map (name: {
      name = "nvim/${name}";
      value.source = ../dotfiles/nvim + "/${name}";
    })
    (builtins.attrNames (builtins.readDir ../dotfiles/nvim))
  );
}
