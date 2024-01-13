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
    darwinConfigurations.liveware-problem = inputs.darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import inputs.nixpkgs {system = "aarch64-darwin";};
      modules = [
        ({pkgs, ...}: {
          users.users.neudoerf.home = "/Users/neudoerf";
          programs.zsh.enable = true;
          environment.shells = [pkgs.bash pkgs.zsh];
          environment.loginShell = pkgs.zsh;
          environment.systemPackages = [pkgs.coreutils pkgs.rectangle];
          nix.extraOptions = ''
            experimental-features = nix-command flakes
          '';
          system.keyboard.enableKeyMapping = true;
          system.keyboard.remapCapsLockToControl = true;
          fonts.fontDir.enable = true;
          fonts.fonts = [(pkgs.nerdfonts.override {fonts = ["FiraCode" "Hack" "Meslo"];})];
          services.nix-daemon.enable = true;
          system.defaults.finder.AppleShowAllExtensions = true;
          system.defaults.finder._FXShowPosixPathInTitle = true;
          system.defaults.dock.autohide = true;
          system.defaults.dock.orientation = "left";
          system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
          system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
          system.defaults.NSGlobalDomain.KeyRepeat = 1;
          system.stateVersion = 4;
        })
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.neudoerf.imports = [
              ({pkgs, ...}: {
                home = {
                  stateVersion = "23.11";
                  # specify home-manager configs
                  packages = [
                    pkgs.alacritty-theme
                    pkgs.bat
                    pkgs.curl
                    pkgs.fd
                    pkgs.htop
                    pkgs.jq
                    pkgs.less
                    pkgs.ripgrep
                  ];
                  sessionVariables = {
                    EDITOR = "nvim";
                    NIX_SHELL_PRESERVE_PROMPT = 1;
                    PAGER = "bat";
                  };
                };
                programs = {
                  fzf = {
                    enable = true;
                    enableZshIntegration = true;
                  };
                  eza.enable = true;
                  eza.enableAliases = true;
                  git.enable = true;
                  zsh = {
                    enable = true;
                    shellAliases = {
                      cat = "bat";
                    };
                  };
                  neovim.enable = true;
                  starship = {
                    enable = true;
                    enableZshIntegration = true;
                    settings = {
                      time.disabled = false;
                      username.show_always = true;
                    };
                  };
                  alacritty = {
                    enable = true;
                    settings = {
                      import = ["${pkgs.alacritty-theme}/tokyo-night.toml"];
                      font = {
                        normal.family = "Hack Nerd Font";
                        size = 14;
                      };
                      window = {
                        dynamic_padding = true;
                        decorations = "buttonless";
                        option_as_alt = "Both";
                      };
                      cursor.style.shape = "Underline";
                    };
                  };
                  zellij = {
                    enable = true;
                    settings = {
                      pane_frames = false;
                      theme = "custom";
                      themes.custom = {
                        fg = "#a9b1d6";
                        bg = "#1a1b26";
                        black = "#383e5a";
                        red = "#f93357";
                        green = "#9ece6a";
                        yellow = "#e0af68";
                        blue = "#7aa2f7";
                        magenta = "#bb9af7";
                        cyan = "#2ac3de";
                        white = "#c0caf5";
                        orange = "#ff9e64";
                      };
                    };
                  };
                };
              })
            ];
          };
        }
      ];
    };
  };
}
