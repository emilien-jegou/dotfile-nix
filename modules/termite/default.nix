{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.termite;
in {
  options.modules.termite = { enable = mkEnableOption "termite"; };

  config = mkIf cfg.enable {
        # termite package
        home.packages = with pkgs; [
          termite
        ];

        # configuration
        home.file.".config/termite/config".source = ./config;
      };
    }
