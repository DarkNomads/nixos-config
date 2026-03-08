{ config, pkgs, ... }:

{
  system.stateVersion = "25.11";
  nix.settings.experimental-features = "nix-command flakes";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_DK.UTF-8";

  users.users.darknomads = {
    isNormalUser = true;
    description = "darknomads";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    steam
  ];

  programs.ssh.startAgent = true;
  virtualisation.docker.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
