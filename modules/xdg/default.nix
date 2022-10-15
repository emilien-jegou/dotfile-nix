{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xdg;

in {
    options.modules.xdg = { enable = mkEnableOption "xdg"; };
    config = mkIf cfg.enable {
        xdg.userDirs = {
            enable = true;
            documents = "$HOME/download/";
            download = "$HOME/download/";
            videos = "$HOME/videos/";
            music = "$HOME/music/";
            pictures = "$HOME/pictures/";
            desktop = "$HOME/home/other/";
            publicShare = "$HOME/download/";
            templates = "$HOME/download/";
        };
    };
}
