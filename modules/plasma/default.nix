{  lib, config, pkgs, inputs, services, ... }:
with lib;
let
    cfg = config.modules.plasma;
in {
    options.modules.plasma = { enable = mkEnableOption "plasma"; };

    config = mkIf cfg.enable {
        lib.services.xserver.displayManager.sddm.enable = true;
        lib.services.xserver.desktopManager.plasma5.enable = true;
        lib.services.xserver.desktopManager.plasma5.excludePackages = with pkgs.libsForQt5; [
          elisa
          khelpcenter
          oxygen
          print-manager
          konsole
        ];
    };
}
