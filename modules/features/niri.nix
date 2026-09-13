{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
    };
  };


  # NOTE: commented this out because we dont need this anymore with home-manager, not deleting it just incase
  # perSystem = { pkgs, lib, self', ... }: {
  #   packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
  #     inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
  #     settings = {
  #       spawn-at-startup = [
  #         (lib.getExe self'.packages.myNoctalia)
  #       ];
  #
  #       xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
  #
  #       input.keyboard.xkb.layout = "us,ua";
  #
  #       layout.gaps = 5;
  #
  #       binds = {
  #         "Mod+T".spawn-sh = lib.getExe pkgs.foot;
  #         "Mod+Q".close-window = [];
  #         "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
  #       };
  #     };
  #   };
  # };
}

