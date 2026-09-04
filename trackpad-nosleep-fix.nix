# In deine configuration.nix einbauen, oder als eigenes Modul importieren
# (z.B. imports = [ ./trackpad-nosleep-fix.nix ]; in der configuration.nix)

{ config, pkgs, lib, ... }:

{
  boot.kernelPatches = [
    {
      name = "t480-trackpad-nosleep";
      patch = pkgs.fetchpatch {
        url = "https://raw.githubusercontent.com/508LoopDetected/t480-trackpad-nosleep/main/rmi4-nosleep.patch";
        # Der Hash unten ist ein Platzhalter. Beim ersten `nixos-rebuild switch`
        # schlägt der Build fehl und zeigt dir den ECHTEN Hash an
        # (Zeile "got: sha256-XXXXXXXX..."). Den dann hier einfach eintragen
        # und nochmal `nixos-rebuild switch` ausführen.
        hash = lib.fakeHash;
      };
    }
  ];
}
