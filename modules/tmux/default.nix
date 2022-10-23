{ inputs, lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.tmux;
in {
    options.modules.tmux = { enable = mkEnableOption "tmux"; };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [ tmux xclip ];

        home.file.".tmux.conf".source = ./tmux.conf;
    };
}
