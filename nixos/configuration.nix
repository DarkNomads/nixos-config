{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = "nix-command flakes";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_DK.UTF-8";

  users.users.darknomads = {
    isNormalUser = true;
    description = "darknomads";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDD72Bgb2WCq/DHet7Dm8phhzE2Hos0473JTRUrf9GUFH7ZcGZaFnR4Wjs64hDSThP8sOo0Is3e8HLUDRsoRYYf2V66i1Rgpfi91ljnSfyxHK+cRS59pb8hZk9TJN+Ynpqd+0M9SyTSWyaDdjoNMWJDyECsDBi3P0H1GTLS819GXrTXkPeXYivLfeImX4E3aXkmfiAJhepS6wsbupthU5eQDIgxD6yZk479BraRITyte7zAWwnSWEZtC4SNV9cw1fqYen/Nva3EcFpGJJyi+E+xAxVCIvsNvkDECoGX6gZBoQQDMe1HdTtnoBjNnqmP+pBOyNtqec3ZYykua3jl46fyLImnJNXTkMpGuZQmuCTaiFeuZ5QowsVR0087pMrLZs7ZvbibDXFZhoV3Rd669lqFLXaolyV5QN48LNfp+dWxPCL38W4l7KSxP8NWgpYK1MNXqfYSFMjs2eIjlLmBbKAr1nFkCEmc5K07C+tLyLd32dJr746lzRuXlEH5je3RskcWAr+nupgQfeTNULWcgCP9QbbRySmjxIgIePaAhZm9x5rfuVdCS9nXaAHyb+jbwAuU+ncpjW8HQqTy+0iM9ufdTKuQPnPcHmoy05LrCQcurnEtcRs35byeiH2nlFRxL9Doy3/qmS1pA0O2bwE4GJpiqfOLbM7Jaxa2+nZAdWp9KQ== ghostnomadjr@gmail.com"
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    steam
  ];

  programs.ssh.startAgent = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  system.stateVersion = "25.11";
}
