{ pkgs, inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel

    ./hardware-configuration.nix

    ../common/global
    ../common/users/ttecho
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/systemd-boot.nix
  ];

  services.greetd.settings.default_session.user = "ttecho";

  
  
  networking = {
    hostName = "deaf";
    networkmanager = {
      enable = true;
    };
    hosts = {
      "127.0.0.1" = [ "localhost.dev" ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  powerManagement.powertop.enable = true;
  
  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };
  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };


    system.stateVersion = "23.05";
  }