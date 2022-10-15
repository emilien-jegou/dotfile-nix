{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.tig;
in {
  options.modules.tig = { enable = mkEnableOption "tig"; };

  config = mkIf cfg.enable {
        # tig package
        home.packages = with pkgs; [ tig ];

        # configuration
        home.file.".tigrc".source = ./tigrc;
      };
    }
