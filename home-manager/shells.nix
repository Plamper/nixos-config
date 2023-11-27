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
    home.packages = with pkgs;[ exa ];
    home.shellAliases = {
      ls = "exa --icons -F -H --group-directories-first --git -1";
    };
  };

}
