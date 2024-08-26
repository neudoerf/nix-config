{ pkgs, ... }:
let
  iosevka-neudoerf = pkgs.callPackage ./iosevka-neudoerf { };
in
{
  fonts.fontconfig.enable = true;
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      alacritty-theme
      bat
      curl
      fd
      glow
      htop
      iosevka-neudoerf
      jq
      less
      lf
      marksman
      neovide
      nil
      nix-index
      nixpkgs-fmt
      nnn
      nodejs
      pandoc
      ripgrep
      tmux
      wezterm
      zola

      lldb
      openocd
      probe-rs-tools
      qemu
      rustup
    ];
  };

  xdg.configFile."starship.toml".source = ./starship/neudoerf.toml;
  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm/wezterm.lua;
  xdg.configFile."tmux/tmux.conf".source = ./tmux/tmux.conf;
  xdg.configFile."neovide/config.toml".source = ./neovide/config.toml;

  programs = {
    alacritty = {
      enable = true;
      settings = {
        import = [ "${pkgs.alacritty-theme}/tokyo-night.toml" ];
        font = {
          normal.family = "IosevkaNeudoerf Nerd Font";
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
    atuin = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = {
        enter_accept = true;
      };
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-night";
        vim_keys = true;
      };
    };
    emacs.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    fish = {
      enable = true;
      shellAliases = {
        PAGER = "bat";
        cat = "bat";
      };
      shellInit = "set fish_greeting";
    };
    fzf.enable = true;
    git = {
      enable = true;
      delta = {
        enable = true;
        options = {
          dark = true;
          line-numbers = true;
          syntax-theme = "Monokai Extended";
        };
      };
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
      userEmail = "tom@neudoerffer.com";
      userName = "Tom Neudoerffer";
    };
    helix = {
      enable = true;
      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "nixpkgs-fmt";
            };
          }
          {
            name = "markdown";
            soft-wrap.enable = true;
          }
        ];
      };
      settings = {
        theme = "tokyonight";
        editor = {
          cursor-shape = {
            insert = "bar";
            normal = "underline";
            select = "block";
          };
          line-number = "relative";
          cursorline = true;
          bufferline = "multiple";
          lsp.display-inlay-hints = true;
          indent-guides.render = true;
        };
      };
    };
    home-manager.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      extraLuaConfig = pkgs.lib.readFile ./neovim/init.lua;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    zellij = {
      enable = true;
      settings = {
        pane_frames = false;
        theme = "tokyo-night-dark";
        themes.draculapro = {
          fg = "#f8f8f2";
          bg = "#22212c";
          black = "#7970a9";
          red = "#ff9580";
          green = "#8aff80";
          yellow = "#ffff80";
          blue = "#9580ff";
          magenta = "#ff80bf";
          cyan = "#80ffea";
          white = "#f8f8f2";
          orange = "#ffca80";
        };
      };
    };
    zsh = {
      enable = true;
      shellAliases = {
        PAGER = "bat";
        cat = "bat";
      };
    };
  };
}
