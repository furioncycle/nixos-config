# Shell for bootstrapping flake-enabled nix and other tooling
# Enter use nix develop

with import <nixpkgs> {};
{ pkgs ? # If pkgs is not defined, instanciate nixpkgs from locked commit
  let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
  import nixpkgs { overlays = [ ]; }
, ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
    NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
      stdenv.cc.cc
      openssl
    ];
    NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
      zig.packages."${system}".master.latest
    ];
  };
}

