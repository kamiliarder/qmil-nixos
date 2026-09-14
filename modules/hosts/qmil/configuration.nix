{self, inputs, ...}: {

flake.nixosModules.qmilConfiguration = { config, pkgs, ... }:

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
  boot.kernelParams = [
        "resume=UUID=143e07c1-06b0-4e62-a1bf-a4f93eba6b62"
        "resume_offset=35168256"
      ];

  # swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 18 * 1024; # 18 GiB
    }
  ];

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
  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "10";
    };

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

  users.users."qmil" = {
    isNormalUser = true;
    description = "qmil";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  programs.firefox.enable = true;
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
    discord
    spotify
    lazygit
    thunar
    cava
    cloudflare-warp
    vesktop
    bruno

    nerd-fonts.jetbrains-mono
    ];

  system.stateVersion = "26.05";
  fonts.fontconfig.enable = true;
};
}
