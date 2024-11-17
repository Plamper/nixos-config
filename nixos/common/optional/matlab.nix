{ inputs, pkgs, ... }: {


  environment.systemPackages = [ inputs.nix-matlab.packages.x86_64-linux.matlab ];

}
