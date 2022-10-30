{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "21.03";
    imports = [
        # desktop
        ./plasma-config

        # gui
        ./firefox
        ./termite
        ./alacritty
        ./tmux

        # cli
        ./nvim
        ./zsh
        ./git
        ./lf
        ./gpg
        ./tig
        ./direnv

        # system
        ./xdg
        ./packages
    ];
}
