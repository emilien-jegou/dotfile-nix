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
        ./lf
        ./gpg
        ./tig
        ./direnv

        # system
        ./xdg
        ./packages
    ];
}
