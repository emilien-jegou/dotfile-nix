{ config, pkgs, inputs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.desktopManager.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    khelpcenter
    oxygen
    print-manager
    konsole
  ];

  environment.systemPackages = with pkgs; [
    slack
    openssl
    jq
    bash
    shellcheck
    obsidian
    discord
    postman
    hamster
    figma-linux
    awscli2
    # dioxus
    dbeaver
    postgresql
    mysql
    sqlite
  ];

  environment.variables = { "QT_STYLE_OVERRIDE" = "kvantum"; };

  # Install fonts
  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
      };
    };
  };

  networking.extraHosts =
  ''
    127.0.0.1	platform.local
    127.0.0.1	operator.platform.local
  '';

  programs.zsh.enable = true;
  programs.dconf.enable = true;
}
