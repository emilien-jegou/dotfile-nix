{ pkgs, lib, config, ... }:

with lib;
let cfg =
  config.modules.packages;
  maintenance = pkgs.writeShellScriptBin "maintenance" ''${builtins.readFile ./maintenance}'';

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ripgrep
      ffmpeg
      tealdeer
      htop
      fzf
      pass
      gnupg
      bat
      unzip
      exa
      lowdown
      zk
      grim
      slurp
      slop
      imagemagick
      age
      libnotify
      git
      python3
      lua
      zig
      mpv
      pqiv
      maintenance
      wf-recorder
      termite
      podman bitwarden
      docker fd
      #firefox-devedition-bin
      flameshot
      git-lfs
      nerdfonts
      stow
      silver-searcher
      thefuck
      tig
      tmux
      #toggldesktop
      zsh
      docker-compose
      nodejs
    ];
  };
}
