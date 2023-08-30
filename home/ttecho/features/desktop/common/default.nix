{ pkgs, lib, outputs, ... }: 
{
  imports = [
    ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
   ];

   xdg.mimeApps.enable = true;
   home.packages = with pkgs; [
    xdg-utils-spawn-terminal
   ];
 }
