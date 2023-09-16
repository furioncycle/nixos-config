{ pkgs ? import <nixpkgs> { } }: rec {

  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord { };

  # Personal scripts
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
  wl-mirror-pick = pkgs.callPackage ./wl-mirror-pick { };
}
