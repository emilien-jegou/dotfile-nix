{ inputs, lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.lf;
in {
    options.modules.lf = { enable = mkEnableOption "lf"; };

    config = mkIf cfg.enable {
        # FIXME: make this wayland/X11 dependant
        home.packages = with pkgs; [ lf xclip wl-clipboard ];

        # configuration
        home.file.".config/lf/lfrc".source = ./lfrc;
    };
}
