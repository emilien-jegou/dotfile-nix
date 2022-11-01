{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.latte-dock;
in {
  options.modules.latte-dock = { enable = mkEnableOption "latte-dock"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ latte-dock ];
  };
}
