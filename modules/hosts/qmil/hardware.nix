{self, inputs, ...}: {

flake.nixosModules.qmilHardware = { config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/143e07c1-06b0-4e62-a1bf-a4f93eba6b62";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7751-09A6";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/d493d856-ddb2-4a79-8b95-28db80f7ea4d";
      fsType = "ext4";
    };

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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
};
}
