{ config, inputs, ... }:
let 
  inherit (config.networking);

  isClean = inputs.self ? rev;
in
{
  system.autoUpgrade = {
    enable = isClean;
    dates = "weekly";
    flags = [
      "--refresh"
    ];
  };
}
