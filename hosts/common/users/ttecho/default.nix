{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = true;
  users.users.ttecho = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
    ] ++ ifTheyExist [
      "network"
      "git"
      "adbusers"
    ];

    packages = [ pkgs.home-manager ];
  };


  home-manager.users.ttecho = import ../../../../home/ttecho/${config.networking.hostName}.nix;

  security.pam.services = { swaylock = { }; };

  # We added myself to not need sudo
  security.sudo.extraRules = [
    { users = [ "ttecho" ];
      commands =  [ {
         command = "ALL";
         options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}