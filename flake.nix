{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    darwinConfigurations.pressure-drop =
      inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; };
        modules = [
          ({ pkgs, ... }: {
            users.users.tom.home = "/Users/tom";
            programs.fish.enable = true;
            environment.shells = [ pkgs.bash pkgs.fish ];
            environment.loginShell = pkgs.fish;
            environment.systemPackages = [ pkgs.coreutils pkgs.rectangle ];
            environment.systemPath = [ "/opt/homebrew/bin" ];
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            system.keyboard.enableKeyMapping = true;
            system.keyboard.remapCapsLockToControl = true;
            fonts.fontDir.enable = false; # DANGER - set to true to enable removing fonts
            fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" "FiraCode" ]; }) ];
            services.nix-daemon.enable = true;
            system.defaults.finder.AppleShowAllExtensions = true;
            system.defaults.finder._FXShowPosixPathInTitle = true;
            system.defaults.dock.autohide = true;
            system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
            system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
            system.defaults.NSGlobalDomain.KeyRepeat = 1;
            system.stateVersion = 4;

            homebrew = {
              enable = true;
              caskArgs.no_quarantine = true;
              global.brewfile = true;
              masApps = {};
              casks = [ "raycast" ];
            };
          })
          inputs.home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.tom.imports = [
                ({ pkgs, ... }: {
                  home.stateVersion = "23.11";
                  # specify home-manager configs
                  home.packages = [
                    pkgs.alacritty-theme
                    pkgs.bat
                    pkgs.curl
                    pkgs.fd
                    pkgs.less
                    pkgs.ripgrep
                    pkgs.rustup
                    pkgs.zellij
                  ];
                  home.sessionVariables = {
                    PAGER = "bat";
                    EDITOR = "nvim";
                  };
                  programs.fzf.enable = true;
                  programs.eza.enable = true;
                  programs.eza.enableAliases = true;
                  programs.git.enable = true;
                  programs.fish.enable = true;
                  programs.neovim.enable = true;
                  programs.fish.shellAliases = {
                    cat = "bat";
                  };
                  programs.starship.enable = true;
                  programs.starship.enableFishIntegration = true;
                  programs.alacritty = {
                    enable = true;
                    settings.import = [ "${pkgs.alacritty-theme}/tokyo-night.yaml" ];
                    settings.font.normal.family = "FiraCode Nerd Font";
                    settings.font.size = 14;
                    settings.window.dynamic_padding = true;
                    settings.window.decorations = "buttonless";
                    settings.window.option_as_alt = "Both";
                    settings.cursor.style.shape = "Underline";
                  };
                })
              ];
            };
          }
        ];
      };
  };
}
