{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      wlogout
      networkmanagerapplet
      swaynotificationcenter
    ];

    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
            "hyprland/language"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "custom/wallpaper"
            "cpu"
            "memory"
            "backlight"
            "pulseaudio"
            "battery"
            "custom/notification"
            "tray"
            "custom/power"
          ];
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              default = "";
              active = "";
            };
          };
          "hyprland/language" = {
            format = "󰌌: {}";
            format-en = "en";
            format-de = "de";
          };
          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };
          pulseaudio = {
            tooltip = true;
            scroll-step = 5;
            format = "{icon} {volume}%";
            format-muted = "{icon} {volume}%";
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            format-icons = {
              default = [ "" "" "" ];
            };
          };

          backlight = {
            tooltip = false;
            format = " {}%";
            interval = 1;
            on-scroll-up = "brightnessctl set +5%";
            on-scroll-down = "brightnessctl set 5%-";
          };
          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{icon}  {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-alt = "{time} {icon}";
            format-icons = [ "" "" "" "" "" ];
          };
          tray = {
            reverse = true;
            icon-size = 18;
            spacing = 10;
          };
          clock = {
            format = "{: %H:%M   %d.%m.%Y}";
          };
          cpu = {
            interval = 15;
            format = " {}%";
            max-length = 10;
          };
          memory = {
            interval = 30;
            format = " {}%";
            max-length = 10;
          };
          "custom/launcher" = {
            tooltip = false;
            format = "󱄅 ";
            on-click = "rofi -show drun";
            on-click-right = "killall rofi";
          };
          "custom/power" = {
            format = "⏻ ";
            on-click = "wlogout";
          };
          # "custom/wallpaper" = {
          #   format = " ";
          #   on-click = "bash ~/.config/system_scripts/pkill_bc";
          # };
        }
      ];
      style = ''

      * {
				border: none;
				border-radius: 10;
			    font-family: "Ubuntu Nerd Font" ;
				font-size: 15px;
				min-height: 10px;
			}

			window#waybar {
				background: transparent;
			}

			window#waybar.hidden {
				opacity: 0.2;
			}

			#window {
				margin-top: 6px;
				padding-left: 10px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
			    color: transparent;
				background: transparent;
			}

			#workspaces {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #bd93f9;
			}

			#pulseaudio {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #1A1826;
				background: #FAE3B0;
			}

			#battery {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #B5E8E0;
			}

			#battery.charging, #battery.plugged {
				color: #161320;
			    background-color: #B5E8E0;
			}

			#battery.critical:not(.charging) {
			    background-color: #B5E8E0;
			    color: #161320;
			    animation-name: blink;
			    animation-duration: 0.5s;
			    animation-timing-function: linear;
			    animation-iteration-count: infinite;
			    animation-direction: alternate;
			}

			@keyframes blink {
			    to {
			        background-color: #BF616A;
			        color: #B5E8E0;
			    }
			}

			#backlight {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #F8BD96;
			}
			#clock {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #ABE9B3;
				/*background: #1A1826;*/
			}

			#memory {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #DDB6F2;
			}
			#cpu {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #96CDFB;
			}

			#tray {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				margin-bottom: 0px;
				padding-right: 10px;
				border-radius: 10px;
				transition: none;
				color: #B5E8E0;
				background: #161320;
			}

			#custom-launcher {
				font-size: 24px;
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 5px;
				border-radius: 10px;
				transition: none;
			    color: #89DCEB;
			    background: #161320;
			}

			#custom-power {
				font-size: 20px;
				margin-top: 6px;
				margin-left: 8px;
				margin-right: 8px;
				padding-left: 10px;
				padding-right: 5px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #F28FAD;
			}

			#custom-wallpaper {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #C9CBFF;
			}
			#custom-notification {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #bd93f9;
			}
			#language {
				margin-top: 6px;
				margin-left: 8px;
				padding-left: 10px;
				padding-right: 10px;
				margin-bottom: 0px;
				border-radius: 10px;
				transition: none;
				color: #161320;
				background: #C9CBFF;
			}
			'';
    };
  };
}
