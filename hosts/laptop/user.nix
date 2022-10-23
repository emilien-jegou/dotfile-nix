{ config, lib, inputs, ...}:

{
    imports = [ ../../modules/default.nix ];

    config.modules = {
      # desktop
      plasma-config.enable = true;

      # gui
      firefox.enable = true;
      termite.enable = true;
      tmux.enable = true;
      tig.enable = true;

      # cli
      nvim.enable = true;
      lf.enable = true;
      zsh.enable = true;
      git.enable = true;
      gpg.enable = true;
      direnv.enable = true;

      # system
      xdg.enable = true;
      packages.enable = true;
    };
}
