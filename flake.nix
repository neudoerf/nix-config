{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS servers track stable; desktops/darwin/home profiles track unstable
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager-stable.url = "github:nix-community/home-manager/release-26.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvf-config = {
    #   url = "github:neudoerf/nvf-config";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      home-manager-stable,
      system-manager,
      nix-system-graphics,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      # NixOS hosts, deployed via deploy-rs to <name>.neunet.ca
      hosts = [
        "appeal-to-reason"
        "long-view"
        "within-reason"
        "recent-convert"
        "size-isnt-everything"
        "space-monster"
      ];

      mkHost =
        name:
        nixpkgs-stable.lib.nixosSystem {
          modules = [
            ./machines/${name}/configuration.nix
            home-manager-stable.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.neudoerf = import ./home-manager/home-server.nix;
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts mkHost;

      deploy.nodes = nixpkgs.lib.genAttrs hosts (name: {
        hostname = "${name}.neunet.ca";
        fastConnection = true;
        profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${name};
        };
      });

      darwinConfigurations.nostalgia-for-infinity = inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        modules = [
          (
            { pkgs, ... }:
            {
              programs.fish.enable = true;
              programs.zsh.enable = true;
              environment = {
                shells = [
                  pkgs.bash
                  pkgs.zsh
                  pkgs.fish
                ];
                systemPackages = [
                  pkgs.coreutils
                  pkgs.rectangle
                ];
              };
              nix.extraOptions = ''
                experimental-features = nix-command flakes
              '';
              system = {
                primaryUser = "neudoerf";
                "stateVersion" = 4;
                defaults = {
                  finder.AppleShowAllExtensions = true;
                  finder._FXShowPosixPathInTitle = true;
                  dock.autohide = true;
                  dock.orientation = "left";
                  NSGlobalDomain = {
                    AppleShowAllExtensions = true;
                    InitialKeyRepeat = 14;
                    KeyRepeat = 1;
                  };
                };
                keyboard = {
                  enableKeyMapping = true;
                  remapCapsLockToControl = true;
                };
              };
              users.users.neudoerf = {
                home = "/Users/neudoerf";
                shell = pkgs.fish;
              };
              fonts = {
                packages = [
                  pkgs.nerd-fonts.fira-code
                  pkgs.nerd-fonts.hack
                  pkgs.nerd-fonts.iosevka
                ];
              };
            }
          )
        ];
      };

      systemConfigs.CPR02395L = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
          {
            config = {
              nixpkgs.hostPlatform = "x86_64-linux";
              system-manager.allowAnyDistro = true;
              system-graphics.enable = true;
            };
          }
        ];
      };

      homeConfigurations = {
        "neudoerf@nostalgia-for-infinity" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/home-cli.nix
            ./home-manager/home-graphical.nix
            ./home-manager/nostalgia-for-infinity.nix
          ];
        };
        "tneudoerffer@CPR02395L" = home-manager.lib.homeManagerConfiguration rec {
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit inputs outputs pkgs; };
          modules = [
            ./home-manager/home-cli.nix
            ./home-manager/home-graphical.nix
            ./home-manager/cpr02395l.nix
          ];
        };
      };
    };
}
