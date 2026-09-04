{ config, pkgs, lib, ... }:

let
  kernel = config.boot.kernelPackages.kernel;

  rmi-core-patched = pkgs.stdenv.mkDerivation {
    pname = "rmi-core-patched";
    version = kernel.version;

    src = kernel.src;

    nativeBuildInputs = kernel.nativeBuildInputs or [];

    kernel_dev = kernel.dev;
    kernelVersion = kernel.modDirVersion;

    patches = [
      (pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/508LoopDetected/t480-trackpad-nosleep/main/rmi4-nosleep.patch";
        hash = "sha256-CzvwJwmqXMH12fMMIz7Tkt/KhQLeKLk465BO4pzU6Oo=";
      })
    ];

    postPatch = kernel.postPatch or "";

    buildPhase = ''
      cp $kernel_dev/lib/modules/$kernelVersion/build/Module.symvers .
      cp $kernel_dev/lib/modules/$kernelVersion/build/.config .

      make -j$NIX_BUILD_CORES modules_prepare
      make -j$NIX_BUILD_CORES M=drivers/input/rmi4 modules
    '';

    installPhase = ''
      mkdir -p $out/lib/modules/$kernelVersion/extra

      cp drivers/input/rmi4/rmi_core.ko \
        $out/lib/modules/$kernelVersion/extra/
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

