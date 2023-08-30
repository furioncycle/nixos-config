{ pkgs ? import <nixpkgs> { } }: rec {

  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord { };
  trekscii = pkgs.callPackage ./trekscii { };

  # Personal scripts
  minicava = pkgs.callPackage ./minicava { };
  pass-wofi = pkgs.callPackage ./pass-wofi { };
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
  wl-mirror-pick = pkgs.callPackage ./wl-mirror-pick { };
  lyrics = pkgs.callPackage ./lyrics { };
  j-and-addons = pkgs.callPackage ./j-and-addons { };
  # My slightly customized plymouth theme, just makes the blue outline white
  # plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome { };
}