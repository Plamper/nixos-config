{ pkgs, config, ... }:
{
  config = {
    programs.bash.enable = true;

    # programs.zsh = {
    #   enable = true;
    #   enableAutosuggestions = true;
    #   enableCompletion = true;
    #   # doesn't seem to work
    #   enableVteIntegration = true;
    #   autocd = true;
    #   shellAliases = {
    #     ll = "ls -l";
    #     update-system = "cd /home/felix/Nix-Configuration && sudo nixos-rebuild switch --flake .#pc";
    #     update-home = "cd /home/felix/Nix-Configuration && home-manager switch --flake .#felix@pc";
    #     update-flake = "cd /home/felix/Nix-Configuration && nix flake update";
    #   };
    #   history = {
    #     size = 10000;
    #     path = "${config.xdg.dataHome}/zsh/history";
    #   };
    #   initExtra = ''bindkey "''${key[Up]}" up-line-or-search'';
    # };
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
        { name = "z"; src = pkgs.fishPlugins.z.src; }
      ];
      shellAbbrs = {
        update-system = "sudo nixos-rebuild switch --flake /home/felix/Nix-Configuration#(echo $hostname)";
        update-flake = "nix flake update /home/felix/Nix-Configuration";
      };
      shellInit = '' 
                # TokyoNight Color Palette
        set -l foreground c0caf5
        set -l selection 2e3c64
        set -l comment 565f89
        set -l red f7768e
        set -l orange ff9e64
        set -l yellow e0af68
        set -l green 9ece6a
        set -l purple 9d7cd8
        set -l cyan 7dcfff
        set -l pink bb9af7

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
        set -g fish_pager_color_selected_background --background=$selection
      '';
    };

    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        add_newline = false;

        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        c.symbol = " ";
        git_branch.symbol = " ";
        package.symbol = "󰏗 ";
        hostname.ssh_symbol = " ";
        rust.symbol = " ";
        directory = {
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
            "Nix-Configuration" = " ";
          };
        };
        # package.disabled = true;
      };
    };
    home.packages = with pkgs;[ eza bat ];
    home.shellAliases = {
      ls = "eza --icons -F -H --group-directories-first --git";
      cat = "bat -pp --theme ansi";
    };
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-storm";
        vim_keys = true;
      };
    };
  };

}
