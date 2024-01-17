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
          environment = {
            shells = [pkgs.bash pkgs.zsh];
            loginShell = pkgs.zsh;
            systemPackages = [pkgs.coreutils pkgs.rectangle];
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
            fonts = [(pkgs.nerdfonts.override {fonts = ["FiraCode" "Hack" "Meslo"];})];
          };
          services.nix-daemon.enable = true;
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
                  atuin = {
                    enable = true;
                    enableZshIntegration = true;
                    settings = {
                      enter_accept = true;
                    };
                  };
                  fzf = {
                    enable = true;
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
