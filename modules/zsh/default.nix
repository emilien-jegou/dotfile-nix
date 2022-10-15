{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zsh;
in {
    options.modules.zsh = { enable = mkEnableOption "zsh"; };

    config = mkIf cfg.enable {
    	home.packages = [
          pkgs.zsh
	];

        home.file.".oh-my-zsh-custom/weynot.zsh-theme".source = ./weynot.zsh-theme;

        programs.zsh = {
            enable = true;
            dotDir = ".config/zsh";
            enableCompletion = true;
            enableAutosuggestions = false;
            enableSyntaxHighlighting = true;

            oh-my-zsh = {
              enable = true;
              theme = "weynot";
              plugins = [ "git" "cp" "sudo" "tmux"];
              custom = "$HOME/.oh-my-zsh-custom";
            };

            # .zshrc
            initExtra = ''
                export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store";
            '';

            # path aliases: `cd ~dotfile` = `cd ~/.config/nixos`
            dirHashes = {
                dotfile = "$HOME/.config/nixos";
            };

            # Tweak settings for history
            history = {
                save = 100000;
                size = 100000;
                path = "$HOME/.cache/zsh_history";
            };

            # Set some aliases
            shellAliases = {
                e = "$EDITOR";
                mkdir = "mkdir -vp";
                rm = "rm -rifv";
                mv = "mv -iv";
                cp = "cp -riv";
                cat = "bat --paging=never --style=plain";
                nd = "nix develop -c $SHELL";
                rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG_DIR --fast; notify-send 'Rebuild complete\!'";
            };

            # Source all plugins, nix-style
            #plugins = [
            #{
            #    name = "auto-ls";
            #    src = pkgs.fetchFromGitHub {
            #        owner = "notusknot";
            #        repo = "auto-ls";
            #        rev = "62a176120b9deb81a8efec992d8d6ed99c2bd1a1";
            #        sha256 = "08wgs3sj7hy30x03m8j6lxns8r2kpjahb9wr0s0zyzrmr4xwccj0";
            #    };
            #}
            #];
    };

    #programs.zsh.ohMyZsh.enable = true;
};
}
