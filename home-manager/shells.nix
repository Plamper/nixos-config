{ pkgs, config, ... }:
{
  config = {
    programs.bash.enable = true;

    programs.fish = {
      enable = true;
      interactiveShellInit =
        # fish
        ''
          set fish_greeting # Disable greeting
          if ! test -f /run/.toolboxenv
            alias ls="eza"
            alias cat="bat"
            alias man="batman"
          end
        '';
      plugins = [
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge.src;
        }
      ];
      shellAbbrs = {
        update-system = "nixos-rebuild switch --flake /home/felix/Nix-Configuration#$hostname --use-remote-sudo";
        update-flake = "nix flake update --flake /home/felix/Nix-Configuration";
      };
      functions = {
        ssh-copy-terminfo =
          # fish
          ''
            if test (count $argv) -ne 1
                echo "Usage: ssh-copy-terminfo SERVER"
                return 1
            end
            set SERVER $argv[1]
            infocmp -x | ssh $SERVER -- tic -x -
          '';
      };
      shellInit =
        # fish
        ''
          # Kanagawa Fish shell theme
          # A template was taken and modified from Tokyonight:
          # https://github.com/folke/tokyonight.nvim/blob/main/extras/fish_tokyonight_night.fish
          set -l foreground DCD7BA normal
          set -l selection 2D4F67 brcyan
          set -l comment 727169 brblack
          set -l red C34043 red
          set -l orange FF9E64 brred
          set -l yellow C0A36E yellow
          set -l green 76946A green
          set -l purple 957FB8 magenta
          set -l cyan 7AA89F cyan
          set -l pink D27E99 brmagenta

          # Syntax Highlighting Colors
          set -g fish_color_normal $foreground
          set -g fish_color_command $cyan
          set -g fish_color_keyword $pink
          set -g fish_color_quote $yellow
          set -g fish_color_redirection $foreground
          set -g fish_color_end $orange
          set -g fish_color_error $red
          set -g fish_color_param $purple
          set -g fish_color_comment $comment
          set -g fish_color_selection --background=$selection
          set -g fish_color_search_match --background=$selection
          set -g fish_color_operator $green
          set -g fish_color_escape $pink
          set -g fish_color_autosuggestion $comment

          # Completion Pager Colors
          set -g fish_pager_color_progress $comment
          set -g fish_pager_color_prefix $cyan
          set -g fish_pager_color_completion $foreground
          set -g fish_pager_color_description $comment
        '';
    };

    programs.zoxide.enable = true;
    # programs.fzf.enable = true;

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
          heuristic = false;
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
    home.packages = with pkgs; [ eza gtrash ];
    home.shellAliases = {
      eza = "eza --icons -F -H --group-directories-first --git --hyperlink";
      bat = "bat -pp";
      # man = "batman";
      # cd = "z";
      gm = "gtrash put";
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
        theme = "kanagawa-dragon";
      };
      themes = {
        tokyonight-moon = {
          src = pkgs.fetchFromGitHub {
            owner = "folke";
            repo = "tokyonight.nvim";
            rev = "9758827c3b380ba89da4a2212b6255d01afbcf08";
            hash = "sha256-qEmfBs+rKP25RlS7VxNSw9w4GnlZiiEchs17nJg7vsE=";
          };
          file = "extras/sublime/tokyonight_moon.tmTheme";
        };
        kanagawa-dragon = {
          src = pkgs.fetchFromGitHub {
            owner = "obergodmar";
            repo = "kanagawa.nvim";
            rev = "extra-setup-tmTheme";
            hash = "sha256-gqXeUxc4BE2NJGlsM1ZIsP9rwonBS388aopCLkZi8UE=";
          };
          file = "extras/tmTheme/kanagawa-dragon.tmTheme";
        };
      };
    };
  };

}
