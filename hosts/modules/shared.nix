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

  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    steam
    tailscale
  ];

  programs.ssh.startAgent = true;
  virtualisation.docker.enable = true;
  services.avahi = { enable = true; nssmdns4 = true; };
  services.printing.enable = true;
  security.rtkit.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = [ "wlr" ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 42420 ];
    allowedUDPPorts = [ 42420 ];
  };
}
