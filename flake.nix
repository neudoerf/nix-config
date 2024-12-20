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
  };

  outputs = { self, nixpkgs, home-manager, system-manager, nix-system-graphics, ... } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      darwinConfigurations.nostalgia-for-infinity = inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ({ pkgs, ... }: {
            programs.fish.enable = true;
            programs.zsh.enable = true;
            environment = {
              shells = [ pkgs.bash pkgs.zsh pkgs.fish ];
              loginShell = pkgs.fish;
              systemPackages = [ pkgs.coreutils pkgs.rectangle ];
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
              packages = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Hack" "Iosevka" "Meslo" ]; }) ];
            };
          })
        ];
      };

      systemConfigs.CPR02395L = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
          ({
            config = {
              nixpkgs.hostPlatform = "x86_64-linux";
              system-manager.allowAnyDistro = true;
              system-graphics.enable = true;
            };
          })
        ];
      };

      homeConfigurations = {
        "neudoerf@nostalgia-for-infinity" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/home.nix
            ./home-manager/nostalgia-for-infinity.nix
          ];
        };
        "tneudoerffer@CPR02395L" = home-manager.lib.homeManagerConfiguration rec {
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
          };
          extraSpecialArgs = { inherit inputs outputs pkgs; };
          modules = [
            ./home-manager/home.nix
            ./home-manager/cpr02395l.nix
          ];
        };
      };
    };
}
