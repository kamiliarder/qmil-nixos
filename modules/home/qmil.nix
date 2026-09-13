{ self, inputs, ... }: {
  flake.nixosModules.qmilHome = { pkgs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.qmil = {
        home.stateVersion = "26.05";
	home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia ];

        xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

        programs.foot.enable = true;
      };
    };
    home-manager.backupFileExtension = "backup";
  };
}
