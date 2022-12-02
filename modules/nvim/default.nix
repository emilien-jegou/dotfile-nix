{  lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.nvim;
in {
    options.modules.nvim = { enable = mkEnableOption "nvim"; };
    config = mkIf cfg.enable {

        home.file.".nvimrc".source = ./nvimrc;
        home.file.".nvim".source = ./nvim-root;
        home.file.".config/nvim".source = ./nvim-config;
        home.file."daily/.clear_empty_notes.sh".source = ./clear_empty_notes;

        home.file = { ".cache/nvim/packages/repos/github.com/shougo/dein.vim".source = pkgs.fetchFromGitHub {
            owner = "Shougo";
            repo = "dein.vim";
            rev = "2.2";
            sha256 = "/79sNwQ7NbJwiszGbxhavuY4/9BQzJpYCH+TcBZOnFw=";
        };
    };

    home.packages = with pkgs; [
        rnix-lsp
        nixfmt
        universal-ctags
    ];

    programs.neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
            vim-nix
        ];
    };
};
}
