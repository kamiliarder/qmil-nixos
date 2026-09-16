{self, inputs, ...}: {

flake.nixosModules.qmilConfiguration = { config, pkgs, lib, ... }:

{
  imports = [
    self.nixosModules.qmilHardware
    self.nixosModules.niri
    self.nixosModules.qmilHome
    inputs.home-manager.nixosModules.home-manager
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Makassar";
  i18n.defaultLocale = "en_US.UTF-8";

  # Desktop
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
  # environment.variables = {
  #   XCURSOR_THEME = "Adwaita";
  #   XCURSOR_SIZE = "10";
  #   };

  services.printing.enable = true;

  # Audio (pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.cloudflare-warp.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };
  systemd.services = {
    mysql.wantedBy = lib.mkForce [ ]; 
    cloudflare-warp.wantedBy = lib.mkForce[];
    };

  users.users."qmil" = {
    isNormalUser = true;
    description = "qmil";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.fish.enable = true;

  programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
  };

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    btop
    foot
    fastfetch
    spotify
    lazygit
    cava
    cloudflare-warp
    vesktop
    bruno
    nwg-displays
    obsidian
    librewolf

    nerd-fonts.jetbrains-mono
    ];

  system.stateVersion = "26.05";
  fonts.fontconfig.enable = true;
};
}
