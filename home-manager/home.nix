{ inputs, outputs, lib, config, pkgs, ... }: {
  home = {
    username = "neudoerf";
    homeDirectory = "/Users/neudoerf";
    stateVersion = "23.11";
    packages = with pkgs; [
      alacritty-theme
      bat
      curl
      fd
      htop
      jq
      less
      nil
      nixpkgs-fmt
      ripgrep
    ];
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
        PAGER = "bat";
        cat = "bat";
      };
    };
    helix = {
      enable = true;
      defaultEditor = true;
      languages = {
        language = [{
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixpkgs-fmt";
          };
        }];
      };
      settings = {
        theme = "tokyonight";
        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "underline";
            select = "block";
          };
        };
      };
    };
    home-manager.enable = true;
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
        import = [ "${pkgs.alacritty-theme}/tokyo-night.toml" ];
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
}
