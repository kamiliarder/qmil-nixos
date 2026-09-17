{ ... }: {

  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        lua_ls
        nil
        nixpkgs-fmt
        statix
        deadnix
      ];
    };
  };
}
