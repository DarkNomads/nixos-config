{ config, pkgs, neovim-nixpkgs, ... }:

{
  home.packages = [
    neovim-nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.neovim
    pkgs.ripgrep
    pkgs.gcc
    pkgs.lua-language-server
    pkgs.typescript-language-server
    pkgs.tailwindcss-language-server
    pkgs.svelte-language-server
    # pkgs.ruby-lsp
  ];
}
