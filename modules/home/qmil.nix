{ self, inputs, ... }: {
  flake.nixosModules.qmilHome = { config, pkgs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.qmil = { config, pkgs, ... }: {
        home.stateVersion = "26.05";

        home.file.".config/nvim".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/home/nvim";

        home.packages = [
          self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia
          pkgs.dbeaver-bin
          pkgs.ripgrep
          pkgs.fd
          pkgs.unzip
          pkgs.gcc
          pkgs.gnumake
          pkgs.python3
          pkgs.wl-clipboard
        ];

        xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;
        xdg.configFile."foot/foot.ini".source = ./foot.ini;

        programs.foot.enable = true;
        programs.fish = {
          enable = true;
          shellAliases = {
            ll = "ls -la";
            cl = "clear";
          };
          shellInit = ''
            set -g fish_greeting ""
            direnv hook fish | source
          '';
        };
      };
    };
    home-manager.backupFileExtension = "backup";
  };
}
