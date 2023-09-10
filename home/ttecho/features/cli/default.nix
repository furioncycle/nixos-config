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
    age
    bc
    bottom
    exa
    ripgrep
    fd
    httpie
    diffsitter
    jq
    typst
    nixfmt
    ltex-ls
    zls
    dafny
  ];
}
