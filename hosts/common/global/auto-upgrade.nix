{ config, inputs, ... }:
let 
  inherit (config.networking) hostName;

  isClean = inputs.self ? rev;
in
{
  system.autoUpgrade {
    enable = isClean;
    dates = "weekly";
    flags = [
      "--refresh"
    ];
  };
}
