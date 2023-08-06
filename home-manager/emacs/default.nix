{ inputs, outputs, lib, config, pkgs, ... }: 
  with pkgs;
  let emacs-package = pkgs.emacs29-pgtk;
  in
    {
      programs.emacs = {
        enable = true;
        package = emacs-package; # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
      };
      services.emacs = {
        enable = true;
        package = emacs-package;
        client.enable = true;
      };
 }




