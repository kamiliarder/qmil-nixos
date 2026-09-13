{ self, inputs, ... }: {
  flake.nixosModules.qmilHome = { pkgs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.qmil = {
        home.stateVersion = "26.05";
	home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia ];

        xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;
        xdg.configFile."foot/foot.ini".source = ./foot.ini;

        programs.foot.enable = true;
	programs.fish = {
	   enable = true;
	   shellAliases = {
	      ll = "ls -la";
	      cl = "clear";
	   };
	   shellInit= ''
	      set -g fish_greeting ""
	   '';
	};
      };
    };
    home-manager.backupFileExtension = "backup";
  };
}
