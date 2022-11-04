{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.alacritty;
in {
  options.modules.alacritty = { enable = mkEnableOption "alacritty"; };

  config = mkIf cfg.enable {
        home.packages = with pkgs; [ alacritty ];
        home.file.".config/alacritty/alacritty.yml".source = ./alacritty.yml;
      };
    }
