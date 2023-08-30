{ pkgs, lib, config, ... }:
{
  programs.git = {
    enable = true;
    userName = "ttecho";
    userEmail = "ttecho2021@gmail.com";
    lfs.enable = true;
    extraConfig.safe.directory = "/etc/nixos";
  };
}
