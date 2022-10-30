{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.alacritty;
in {
  options.modules.alacritty = { enable = mkEnableOption "alacritty"; };

  config = mkIf cfg.enable {
        # alacritty package
        home.packages = with pkgs; [
          alacritty
        ];

        # configuration
        home.file.".config/alacritty/config".source = ./config;
      };
    }
