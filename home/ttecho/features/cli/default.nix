{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./pfetch.nix
    ./ranger.nix
    ./shellcolor.nix
    ./starship.nix
  ];
  home.packages = with pkgs; [
    bc
    bottom
    eza
    ripgrep
    fd
    jq
    nixfmt
  ];
}
