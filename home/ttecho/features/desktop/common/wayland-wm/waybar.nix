{ config, lib, pkgs, ... }:

let
  # Dependencies
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btm = "${pkgs.bottom}/bin/btm";
  terminal = "${pkgs.kitty}/bin/kitty";
  terminal-spawn = cmd: "${terminal} $SHELL -i -c ${cmd}";
  systemMonitor = terminal-spawn btm;
in
{
  programs.waybar = {
    enable = true;
    settings = {
      primary = {
        layer = "top";
        position = "top";
        modules-left = (lib.optionals config.wayland.windowManager.sway.enable [
          "sway/workspaces"
          "sway/mode"
          "custom/right-arrow-dark"
        ]) ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
          "wlr/workspaces"
        ]);

        "wlr/workspaces" = {
          on-click = "activate";
        };
        modules-center = [
          "custom/left-arrow-dark"
		      "clock#1"
		      "custom/left-arrow-light"
		      "custom/left-arrow-dark"
		      "clock#2"
		      "custom/right-arrow-dark"
		      "custom/right-arrow-light"
		      "clock#3"
		      "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "memory"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "cpu"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "battery"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "network"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"          
          "custom/hostname"
        ];

        "custom/left-arrow-dark"= {
	      	format= "";
	      };
	      "custom/left-arrow-light"={
	      	format="";
	      };
	      "custom/right-arrow-dark"= {
	      	format="";
	      };
	      "custom/right-arrow-light"= {
	      	format="";
	      };

        "clock#1" = {
          format = "{:%a}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';        
        };

        "clock#2" = {
          format = "{:%H:%M}";
        };
        "clock#3" = {
          format = "{:%m-%d}";
        };

        cpu = {
          format = "   {usage}%";
          on-click = systemMonitor;
        };
        memory = {
          format = "󰍛  {}%";
          interval = 5;
          on-click = systemMonitor;
        };
        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [ "" "" "" ];
          };
          on-click = pavucontrol;
        };
        
        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
        };

        "sway/window" = {
          max-length = 20;
        };
#        "sway/workspaces" = {
#          disable-scroll = true;
#          format = "{name}";
#        };
        network = {
          interval = 3;
          format-wifi = " ";
          format-ethernet = "󰈁";
          format-disconnected = "";
          tooltip-format = ''
            {essid}
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };
        "custom/hostname" = {
          exec = "echo $USER@$(hostname)";
          on-click = terminal;
        };
      };

    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left

    style = /* css */ ''
      * {
        font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
        font-size: 15px;
      }

      window#waybar {
      	background: #292b2e;
      	color: #fdf6e3;
      }
      
      #custom-right-arrow-dark,
      #custom-left-arrow-dark {
      	color: #1a1a1a;
      }
      #custom-right-arrow-light,
      #custom-left-arrow-light {
      	color: #292b2e;
      	background: #1a1a1a;
      }
      
      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #custom-hostname,
      #network {
      	background: #1a1a1a;
      }

      #workspaces button {
      	padding: 0 2px;
      	color: #fdf6e3;
      }
      #workspaces button.focused {
      	color: #268bd2;
      }
      #workspaces button:hover {
      	box-shadow: inherit;
      	text-shadow: inherit;
      }

      #workspaces button:hover {
      	background: #1a1a1a;
      	border: #1a1a1a;
      	padding: 0 3px;
      }

      #pulseaudio {
      	color: #268bd2;
      }
      #memory {
      	color: #2aa198;
      }
      #cpu {
      	color: #6c71c4;
      }
      #battery {
      	color: #859900;
      }
      #disk {
      	color: #b58900;
      }

      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk
      #network {
      	padding: 0 2px;
      }    
    '';
  };
}
