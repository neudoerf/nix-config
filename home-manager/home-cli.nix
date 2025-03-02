{ pkgs, inputs, ... }:
{
  home = {
    stateVersion = "23.11";
    packages =
      with pkgs;
      [
        bat
        curl
        dust
        fd
        glow
        htop
        jq
        lazygit
        less
        lf
        marksman
        nil
        nix-index
        nixpkgs-fmt
        nnn
        nodejs
        pandoc
        ripgrep
        tmux
        zola

        # dev
        lldb
        openocd
        probe-rs-tools
        qemu
        rustup
        shellcheck
      ]
      ++ [ inputs.nvf-config.packages.${pkgs.system}.default ];
  };

  xdg = {
    configFile = {
      "starship.toml".source = ./starship/neudoerf.toml;
      "wezterm/wezterm.lua".source = ./wezterm/wezterm.lua;
      "tmux/tmux.conf".source = ./tmux/tmux.conf;
    };
  };

  programs = {
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
    zsh = {
      enable = true;
      shellAliases = {
        PAGER = "bat";
        cat = "bat";
      };
    };
  };
}
