{
  inputs,
  lib,
  config,
  ...
}:
{
  # Taken from nix starter configs
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {

        # For Cachix
        trusted-users = [
          "root"
          "felix"
        ];

        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
        # Opinionated: disable global registry
        flake-registry = "";
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
      };
      # Opinionated: disable channels
      channel.enable = false;

      # Opinionated: make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    };

  programs.nh = {
    enable = true;
    flake = "/home/felix/Nix-Configuration";
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

}
