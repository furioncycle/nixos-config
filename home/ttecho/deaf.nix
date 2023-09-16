{ inputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/cli
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  wallpaper = "/etc/nixos/home/ttecho/wallpapers/spill.jpg"; 
  
  monitors = [{
    name = "eDP-1";
    width = 1920;
    height = 1080;
    workspace = "1";
  }];
}