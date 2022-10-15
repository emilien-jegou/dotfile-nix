{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "21.03";
    imports = [
        # desktop environment
        ./plasma

        # gui
        ./firefox
        ./termite
        ./tmux

        # cli
        ./nvim
        ./zsh
        ./git
        ./gpg
        ./tig
        ./direnv

        # system
        ./xdg
        ./packages
    ];
}
