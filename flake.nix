{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
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
              fonts = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Hack" "Meslo" ]; }) ];
            };
            services.nix-daemon.enable = true;
          })
        ];
      };

      homeConfigurations = {
        "neudoerf@liveware-problem" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/home.nix
            ./home-manager/liveware-problem.nix
          ];
        };
        "tneudoerffer@CPR02349L" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/home.nix
            ./home-manager/cpr02349l.nix
          ];
        };
      };
    };
}
