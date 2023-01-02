{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
  options.modules.git = { enable = mkEnableOption "git"; };
  config = mkIf cfg.enable {

    home.file.".config/git/gitmessage".source = ./gitmessage;
    home.file.".config/git/scripts/easy_fixup".source = ./easy_fixup.sh;

    programs.git = {
      enable = true;
      userName = "Emilien Jegou";
      extraConfig = {
        init = {
          defaultBranch = "main";
          #templatedir = "~/.config/git/templates";
        };
        core = { 
          excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
          pager =  "less -F -X";
        };
        gui = { editor = "/usr/bin/nvim"; }; # TODO: make this line dependant on the config
        advice = { statusHints = false; };
        rebase = { autosquash = true; autostash = true; };
        merge = { ff = "only"; tool = "vimdiff"; };
        push = { default = "current"; };
        commit = { template = "~/.config/git/gitmessage"; };
        fetch = { prune = true; };
        include = { path = "~/.config/git/gitconfig"; };
        diff = { colorMoved = "zebra"; };
        color = { ui = "auto"; diff = "auto"; branch = "auto"; };
        alias = {
          unstage = "reset HEAD --";
          uncommit = "reset --soft HEAD^";
          fx = "!~/.config/git/scripts/easy_fixup";
          amend = "commit --amend";
          aa = "add --all";
          ap = "add --patch";
          r = "rebase";
          ri = "rebase -i";
          branches = "for-each-ref --sort=-committerdate --format=\"%(color:blue)%(authordate:relative)\t%(color:red)%(authorname)\t%(color:white)%(color:bold)%(refname:short)\" refs/remotes # Test this";
          co = "commit -v";
          ck = "checkout";
          pf = "push --force-with-lease";
          st = "status --short -M";
          dc = "diff --color-words";
          df = "diff --color-words $1~ $1";
          incoming = "log --all --decorate --graph --oneline origin/master ^master";
          outgoing = "log --all --decorate --graph --oneline master ^origin/master";
          pick = "!git cherry-pick --ff \"..$1\"";
          l = "log --decorate --graph --oneline -20";
          ll = "log --decorate --graph --oneline";
          sla = "log --all --decorate --graph --oneline";
          # rl = "reflog -20"
        };
      };
    };
  };
}
