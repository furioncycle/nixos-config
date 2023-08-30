{ inputs, lib, ... }:
{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
      system-features = [ "nixos-test" "big-parallel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };

    registry = lib.mapAttrs (_: value: {flake = value; }) inputs;

    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };
}