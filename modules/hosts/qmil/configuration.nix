{self, inputs, ...}: {

flake.nixosModules.qmilConfiguration = { config, pkgs, lib, ... }:

{
  imports = [
    self.nixosModules.qmilHardware
    self.nixosModules.niri
    self.nixosModules.noctalia
    self.nixosModules.qmilHome
    inputs.home-manager.nixosModules.home-manager
  ];

  # Bootloader

  boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;

        plymouth = {
          enable = true;
          themePackages = [ inputs.evangelion-ui.packages.${pkgs.system}.evangelion-ui ];
          theme = "evangelion-ui";
        };

        initrd = {
          systemd.enable = true;
          # kernelModules = [ "amdgpu" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
        };

        consoleLogLevel = 3;

        initrd.verbose = false;

        kernelParams = [
          "quiet"
          "splash"
          "rd.udev.log_level=3"
          "rd.systemd.show_status=auto"
        ];

        loader.timeout = 5;
      };

  # Enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.enableIPv6 = false;
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;

    settings = {
          connection = {
            "ipv6.method" = "ignore";
          };
        };
  };

  time.timeZone = "Asia/Makassar";
  i18n.defaultLocale = "en_US.UTF-8";

  # trusted users
  nix.settings.trusted-users = [ "root" "qmil" ];

  # Desktop
  services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;
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

  programs.firefox.enable = true;

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };


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
    ];

  system.stateVersion = "26.05";

  fonts = {
    packages = with pkgs; [
      nerd-fonts._3270
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.go-mono
    ];

    fontconfig.enable = true;

      };
};
}
