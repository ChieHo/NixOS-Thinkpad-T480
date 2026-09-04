{ config, pkgs, lib, ... }:

let
  kernel = config.boot.kernelPackages.kernel;

  rmi-core-patched = pkgs.stdenv.mkDerivation {
    pname = "rmi-core-patched";
    version = kernel.version;

    inherit (kernel) src version postPatch nativeBuildInputs;

    kernel_dev = kernel.dev;
    kernelVersion = kernel.modDirVersion;

    modulePath = "drivers/input/rmi4";

    patches = [
      (pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/508LoopDetected/t480-trackpad-nosleep/main/rmi4-nosleep.patch";
        hash = "sha256-CzvwJwmqXMH12fMMIz7Tkt/KhQLeKLk465BO4pzU6Oo=";
      })
    ];

    buildPhase = ''
      BUILT_KERNEL=$kernel_dev/lib/modules/$kernelVersion/build

      cp $BUILT_KERNEL/Module.symvers .
      cp $BUILT_KERNEL/.config .
      cp $kernel_dev/vmlinux .

      make "-j$NIX_BUILD_CORES" modules_prepare
      make "-j$NIX_BUILD_CORES" M=$modulePath modules
    '';

    installPhase = ''
      make \
        INSTALL_MOD_PATH="$out" \
        XZ="xz -T$NIX_BUILD_CORES" \
        M="$modulePath" \
        modules_install
    '';

    meta = {
      description = "Patched rmi_core kernel module for T480 trackpad";
      license = lib.licenses.gpl2Only;
    };
  };
in
{
  boot.extraModulePackages = [
    rmi-core-patched
  ];

  boot.kernelModules = [
    "rmi_core"
  ];
}
