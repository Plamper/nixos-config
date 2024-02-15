{ pkgs, config, ... }:
{
  config = {
    programs.bash.enable = true;

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
      ];
      shellAbbrs = {
        update-system = "sudo nixos-rebuild switch --flake /home/felix/Nix-Configuration#(echo $hostname)";
        update-flake = "nix flake update /home/felix/Nix-Configuration";
      };
      shellInit = '' 
                # Adwaita Color Palette
        set -l foreground DEDDDA
        set -l selection 193D66
        set -l comment 5E5C64
        set -l red BF1C28
        set -l orange FF7800
        set -l yellow F8E45C
        set -l green 5BC8AF
        set -l purple C061CB
        set -l cyan 33C7DE
        set -l pink bb9af7

        # Syntax Highlighting Colors
        set -g fish_color_normal $cyan
        set -g fish_color_command $foreground
        set -g fish_color_keyword $purple
        set -g fish_color_quote $green
        set -g fish_color_redirection $cyan
        set -g fish_color_end $orange
        set -g fish_color_error $red
        set -g fish_color_param $green
        set -g fish_color_comment $comment
        set -g fish_color_selection --background=$selection
        set -g fish_color_search_match --background=$selection
        set -g fish_color_operator $orange
        set -g fish_color_escape $purple
        set -g fish_color_autosuggestion $comment

        # Completion Pager Colors
        set -g fish_pager_color_progress $comment
        set -g fish_pager_color_prefix $cyan
        set -g fish_pager_color_completion $foreground
        set -g fish_pager_color_description $comment
        set -g fish_pager_color_selected_background --background=$selection
      '';
    };

    programs.zoxide.enable = true;

    programs.nushell = {
      enable = true;
      package = pkgs.unstable.nushell;
    };

    programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        add_newline = false;
        # format = "[](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php$c$package[](fg:#212736 bg:#1d2230)$nix_shell[ ](fg:#1d2230)\n$character";
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        c = {
          symbol = " ";
          # format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)"; 
          # style = "bg:#212736";
        };
        package = {
          symbol = "󰏗 ";
          # format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)"; 
          # style = "bg:#212736";
        };
        rust = {
          # format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)"; 
          # style = "bg:#212736";
          symbol = " ";
        };
        git_branch = {
          # format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
          # style = "bg:#394260"; 
          symbol = " ";
        };
        # git_status = {
        #   format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)"; 
        #   style = "bg:#394260";
        # };
        nodejs = {
          # format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)"; 
          # style = "bg:#212736"; 
          symbol = " ";
        };
        golang = {
          # format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)"; 
          # style = "bg:#212736"; 
          symbol = " ";
        };
        nix_shell = {
          # format = "[[ $symbol $state( \($name\))](fg:#a0a9cb bg:#1d2230)]($style)"; 
          # style = "bg:#1d2230";
          heuristic = true;
          symbol = " ";
        };
        directory = {
          # format = "[ $path ]($style)"; 
          # style = "fg:#e3e5e5 bg:#769ff0";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
          };
        };
        # package.disabled = true;
      };
    };
    home.packages = with pkgs;[ eza unstable.inshellisense ];
    home.shellAliases = {
      ls = "eza --icons -F -H --group-directories-first --git";
      cat = "bat -pp";
      man = "batman";
    };
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-storm";
        vim_keys = true;
      };
    };
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
      config = {
        theme = "adwaita-dark";
      };
      themes = {
        # tokyonight-storm = {
        #   src = pkgs.fetchFromGitHub {
        #     owner = "folke";
        #     repo = "tokyonight.nvim";
        #     rev = "f247ee700b569ed43f39320413a13ba9b0aef0db";
        #     hash = "sha256-axjZVZOI+WIv85FfMG+lxftDKlDIw/HzQKyJVFkL33M=";
        #   };
        #   file = "extras/sublime/tokyonight_storm.tmTheme";
        # };
        adwaita-dark = {
          src = ./themes;
          file = "adwaita-dark.tmTheme";
        };
      };
    };
  };

}
