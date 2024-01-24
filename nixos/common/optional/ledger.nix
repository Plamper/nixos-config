{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs;[
      unstable.ledger-live-desktop
      monero-gui
    ];
    hardware.ledger.enable = true;
  };
}
