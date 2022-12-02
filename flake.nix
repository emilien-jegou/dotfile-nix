{
  description = "NixOS configuration";

    # All inputs for the system
    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      plasma-manager.url = "github:pjones/plasma-manager";
      plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
      plasma-manager.inputs.home-manager.follows = "home-manager";

    };

    # All outputs for the system (configs)
    outputs = { home-manager, nixpkgs, nur, plasma-manager, ... }@inputs:
    let
      system = "x86_64-linux"; #current system
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;

        # This lets us reuse the code to "create" a system
        # Credits go to sioodmy on this one!
        # https://github.com/sioodmy/dotfiles/blob/main/flake.nix
        mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            # General configuration (users, networking, sound, etc)
            ./system/configuration.nix
            # Hardware config (bootloader, kernel modules, filesystems, etc)
            # DO NOT USE MY HARDWARE CONFIG!! USE YOUR OWN!!
            (./. + "/hosts/${hostname}/custom.nix")
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                # Home manager config (configures programs like firefox, zsh, etc)
                users.emilien.imports = [
                  inputs.plasma-manager.homeManagerModules.plasma-manager
                  (./. + "/hosts/${hostname}/user.nix")
                ];
              };
              nixpkgs.overlays = [
                # Add nur overlay for Firefox addons
                nur.overlay
                (import ./overlays)
              ];
            }
          ];
          specialArgs = { inherit inputs; };
        };

    in {
      inputs.nixpkgs.config.allowUnfree = true;
      nixosConfigurations = {
        # Now, defining a new system is can be done in one line
        #                                   Architecture   Hostname
        laptop    = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
        thinkpad  = mkSystem inputs.nixpkgs "x86_64-linux" "thinkpad";
      };
    };
  }
