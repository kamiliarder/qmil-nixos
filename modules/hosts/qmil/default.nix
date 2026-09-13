{self, inputs, ...}: {

flake.nixosConfigurations.qmil = inputs.nixpkgs.lib.nixosSystem {
	modules = [ 
		self.nixosModules.qmilConfiguration
		];
	};
}
