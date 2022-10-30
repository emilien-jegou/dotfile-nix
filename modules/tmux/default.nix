{ inputs, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.modules.tmux;
in {
  options.modules.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    home.file = { ".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "v3.0.0";
      sha256 = "qYBMDLIEkgiTFxjlF8AHn31HZ4nt/ZoeerzX70SSBaM=";
    };
  };

  home.packages = with pkgs; [ tmux xclip ];

  home.file.".tmux.conf".source = ./tmux.conf;
};
  }
