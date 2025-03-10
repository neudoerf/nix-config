{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

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

    nvf-config = {
      url = "github:neudoerf/nvf-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      system-manager,
      nix-system-graphics,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      nixosConfigurations = {
        appeal-to-reason = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/appeal-to-reason/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.neudoerf = import ./home-manager/home-cli.nix;
              };
            }
          ];
        };
        long-view = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/long-view/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.neudoerf = import ./home-manager/home-cli.nix;
              };
            }
          ];
        };
        within-reason = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/within-reason/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.neudoerf = import ./home-manager/home-cli.nix;
              };
            }
          ];
        };
        recent-convert = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/recent-convert/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.neudoerf = import ./home-manager/home-cli.nix;
              };
            }
          ];
        };
        size-isnt-everything = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/size-isnt-everything/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.neudoerf = import ./home-manager/home-cli.nix;
              };
            }
          ];
        };
        space-monster = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          system = "x86_64-linux";
          modules = [
            ./machines/space-monster/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users.neudoerf = import ./home-manager/home-cli.nix;
              };
            }
          ];
        };
      };
      deploy.nodes = {
        appeal-to-reason = {
          hostname = "appeal-to-reason.neunet.ca";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.appeal-to-reason;
          };
        };
        long-view = {
          hostname = "long-view.neunet.ca";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.long-view;
          };
        };
        within-reason = {
          hostname = "within-reason.neunet.ca";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.within-reason;
          };
        };
        recent-convert = {
          hostname = "recent-convert.neunet.ca";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.recent-convert;
          };
        };
        size-isnt-everything = {
          hostname = "size-isnt-everything.neunet.ca";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.size-isnt-everything;
          };
        };
        space-monster = {
          hostname = "10.1.50.20";
          fastConnection = true;
          profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.space-monster;
          };
        };
      };
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
              services = {
                nix-daemon.enable = true;
              };
              system = {
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
