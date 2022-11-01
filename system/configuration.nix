{ config, pkgs, inputs, ... }:

{
    # Remove unecessary preinstalled packages
    environment.defaultPackages = [ ];

    # Laptop-specific packages (the other ones are installed in `packages.nix`)
    environment.systemPackages = with pkgs; [
      acpi
      tlp
      git
      nix-index
    ];

    # Nix settings, auto cleanup and enable flakes
    nix = {
      settings.auto-optimise-store = true;
      settings.allowed-users = [ "emilien" ];
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      '';
    };

    # Boot settings: clean /tmp/, latest kernel and enable bootloader
    boot = {
      cleanTmpDir = true;
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
        };
        grub = {
          enable = false;
          efiSupport = true;
          #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
          device = "nodev";
        };
        systemd-boot.enable = false;
       #systemd-boot.editor = false;
       timeout = 30;
     };
   };

   boot.supportedFilesystems = [ "ntfs" ];

    # Set up locales (timezone and keyboard layout)
    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
      keyMap = "us";
    };

    # Set up user and enable sudo
    users.users.emilien = {
      isNormalUser = true;
      extraGroups = [ "input" "wheel" ];
      shell = pkgs.zsh;
    };

    # Set up networking and secure it
    networking = {
      networkmanager.enable = true;
      networkmanager.wifi.backend = "iwd";
      wireless.iwd.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [ 443 80 ];
        allowedUDPPorts = [ 443 80 44857 ];
        allowPing = false;
      };
    };

    # Set environment variables
    environment.variables = {
      NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
      XDG_DATA_HOME = "$HOME/.local/share";
      PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc"; # move this line ?
      GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc"; # move this line ?
      ZK_NOTEBOOK_DIR = "$HOME/stuff/notes/";
      EDITOR = "nvim";
      BROWSER= "firefox";
      DIRENV_LOG_FORMAT = "";
      DISABLE_QT5_COMPAT = "0";
    };

    # Security
    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        extraRules = [{
          users = [ "emilien" ];
          keepEnv = true;
          persist = true;
        }];
      };

      # Extra security
      protectKernelImage = true;
    };

    # Sound
    sound = {
      enable = true;
    };

    hardware.pulseaudio.enable = true;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = false;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    hardware = {
      bluetooth.enable = true;
      opengl = {
        enable = true;
        driSupport = true;
      };
    };

    # Do not touch
    system.stateVersion = "20.09";
  }
