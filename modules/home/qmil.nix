{ self, inputs, ... }: {
  flake.nixosModules.qmilHome = { pkgs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.qmil = {
        home.stateVersion = "26.05";

        xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

        programs.foot.enable = true;
      };
    };
    home-manager.backupFileExtension = "backup";
  };
}
