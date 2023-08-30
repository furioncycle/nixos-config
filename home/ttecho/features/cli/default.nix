{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./pfetch.nix
    ./ranger.nix
    ./screen.nix
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
    trekscii
    typst
    nixfmt
    joplin-desktop
    ltex-ls
    zls
    dafny
  ];
}
