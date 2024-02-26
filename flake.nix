{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixgl, ... } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      darwinConfigurations.liveware-problem = inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ({ pkgs, ... }: {
            users.users.neudoerf.home = "/Users/neudoerf";
            programs.zsh.enable = true;
            environment = {
              shells = [ pkgs.bash pkgs.zsh ];
              loginShell = pkgs.zsh;
              systemPackages = [ pkgs.coreutils pkgs.rectangle ];
            };
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
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
            fonts = {
              fontDir.enable = true;
              fonts = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Hack" "Iosevka" "Meslo" ]; }) ];
            };
            services.nix-daemon.enable = true;
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
        "tneudoerffer@CPR02349L" = home-manager.lib.homeManagerConfiguration rec {
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ nixgl.overlay ];
          };
          extraSpecialArgs = { inherit inputs outputs pkgs; };
          modules = [
            ./home-manager/home.nix
            ./home-manager/cpr02349l.nix
          ];
        };
      };
    };
}
