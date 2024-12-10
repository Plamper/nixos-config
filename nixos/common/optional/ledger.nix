{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs;[
      ledger-live-desktop
      monero-gui
    ];
    hardware.ledger.enable = true;
  };
}
