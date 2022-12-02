{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zsh;
in {
  options.modules.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.zsh
      pkgs.direnv
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
         export PATH="$PATH:$HOME/.local/bin/";

         eval "$(direnv hook zsh)"

         # launch process in background
         # nohup without the clutter
         function nup {
           echo Running "''${@[*]}"
           nohup "''${@[*]}" </dev/null >/dev/null 2>&1 &
           disown
         }

         function agf {
            ag "''${@[*]}" | grep -v '^[0-9]' | grep -v '^$' | cut -d':' -f1 | uniq
         }
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
       mkd = "mkdir -vp";
       rm = "rm -rifv";
       mv = "mv -iv";
       cp = "cp -riv";
       cat = "bat --paging=never --style=plain";
       browse = "$BROWSER";
       g = "grep --color";
       ipinfo = "curl ipinfo.io 2>/dev/null | jq";
       sss = "sudo ss -tulpn";
       ls = "exa --git";
       lt = "exa --git -l -T";
       reloadTmux = "tmux source-file ~/.tmux.conf";
       SS = "sudo systemctl";
       "cd.." = "cd ..";
       weather = "curl https://wttr.in/";
       gst = "git status --short";
       doco = "docker-compose";
       grc = "git rebase --continue";
       nd = "nix develop -c $SHELL";
       hg = "history | grep";
       n = "nup dolphin";
       rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG_DIR --fast; notify-send 'Rebuild complete\!'";
     };
   };
 };
}
