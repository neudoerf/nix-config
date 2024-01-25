{ inputs, outputs, lib, config, pkgs, ... }: {
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      alacritty-theme
      bat
      curl
      fd
      htop
      jq
      less
      marksman
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
          lsp.display-inlay-hints = true;
        };
      };
    };
    home-manager.enable = true;
    neovim.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        aws.format = "[$symbol($profile)(\\($region\\))(\\[$duration\\])]($style) ";
        aws.symbol = "  ";
        buf.symbol = " ";
        bun.format = "[$symbol($version)]($style) ";
        c.format = "[$symbol($version(-$name))]($style)  ";
        c.symbol = " ";
        conda.symbol = " ";
        cmake.format = "[$symbol($version)]($style) ";
        cmd_duration.format = "[⏱ $duration]($style) ";
        cobol.format = "[$symbol($version)]($style) ";
        conda.format = "[$symbol$environment]($style) ";
        crystal.format = "[$symbol($version)]($style) ";
        crystal.symbol = " ";
        daml.format = "[$symbol($version)]($style) ";
        dart.format = "[$symbol($version)]($style) ";
        dart.symbol = " ";
        deno.format = "[$symbol($version)]($style) ";
        directory.format = "[$path]($style)[$read_only]($read_only_style) ";
        directory.read_only = " 󰌾";
        docker_context.format = "[$symbol$context]($style) ";
        docker_context.symbol = " ";
        dotnet.format = "[$symbol($version)(🎯 $tfm)]($style) ";
        elixir.format = "[$symbol($version \\(OTP $otp_version\\))]($style) ";
        elixir.symbol = " ";
        elm.format = "[$symbol($version)]($style) ";
        elm.symbol = " ";
        erlang.format = "[$symbol($version)]($style) ";
        fennel.format = "[$symbol($version)]($style) ";
        fennel.symbol = " ";
        fossil_branch.format = "[$symbol$branch]($style) ";
        fossil_branch.symbol = " ";
        gcloud.format = "[$symbol$account(@$domain)(\\($region\\))]($style) ";
        git_branch.format = "[$symbol$branch]($style)";
        git_branch.symbol = " ";
        git_status.format = " ([\\[$all_status$ahead_behind\\]]($style)) ";
        golang.format = "[$symbol($version)]($style) ";
        golang.symbol = " ";
        gradle.format = "[$symbol($version)]($style) ";
        guix_shell.format = "[$symbol]($style) ";
        guix_shell.symbol = " ";
        haskell.format = "[$symbol($version)]($style) ";
        haskell.symbol = " ";
        haxe.format = "[$symbol($version)]($style) ";
        haxe.symbol = " ";
        helm.format = "[$symbol($version)]($style) ";
        hg_branch.format = "[$symbol$branch]($style) ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = " ";
        java.format = "[$symbol($version)]($style) ";
        java.symbol = " ";
        julia.format = "[$symbol($version)]($style) ";
        julia.symbol = " ";
        kotlin.format = "[$symbol($version)]($style) ";
        kotlin.symbol = " ";
        kubernetes.format = "[$symbol$context( \\($namespace\\))]($style) ";
        lua.format = "[$symbol($version)]($style)\]";
        lua.symbol = " ";
        memory_usage.format = "[$symbol($version)]($style) ";
        memory_usage.symbol = "󰍛 ";
        meson.format = "[$symbol$project]($style) ";
        meson.symbol = "󰔷 ";
        nim.format = "[$symbol($version)]($style) ";
        nim.symbol = "󰆥 ";
        nix_shell.format = "[$symbol$state]($style)\]";
        nix_shell.symbol = " ";
        nodejs.format = "[$symbol($version)]($style) ";
        nodejs.symbol = " ";
        ocaml.format = "[$symbol($version)(\\($switch_indicator$switch_name\\))]($style) ";
        ocaml.symbol = " ";
        opa.format = "[$symbol($version)]($style) ";
        openstack.format = "[$symbol$cloud(\\($project\\))]($style) ";
        os.format = "[$symbol]($style) ";
        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Windows = "󰍲 ";
        };
        package.format = "[$symbol$version]($style) ";
        package.symbol = "󰏗 ";
        perl.format = "[$symbol($version)]($style) ";
        perl.symbol = " ";
        php.format = "[$symbol($version)]($style) ";
        php.symbol = " ";
        pijul_channel.format = "[$symbol$channel]($style) ";
        pijul_channel.symbol = " ";
        pulumi.format = "[$symbol$stack]($style) ";
        purescript.format = "[$symbol($version)]($style) ";
        python.format = "[\${symbol}\${pyenv_prefix}(\${version})(\\($virtualenv\\))]($style) ";
        python.symbol = " ";
        raku.format = "[$symbol($version-$vm_version)]($style) ";
        red.format = "[$symbol($version)]($style) ";
        rlang.symbol = "󰟔 ";
        ruby.format = "[$symbol($version)]($style) ";
        ruby.symbol = " ";
        rust.format = "[$symbol($version)]($style) ";
        rust.symbol = " ";
        scala.format = "[$symbol($version)]($style) ";
        scala.symbol = " ";
        solidity.format = "[$symbol($version)]($style) ";
        spack.format = "[$symbol$environment]($style) ";
        sudo.format = "[as $symbol]($style) ";
        swift.format = "[$symbol($version)]($style) ";
        swift.symbol = " ";
        terraform.format = "[$symbol$workspace]($style) ";
        time.disabled = false;
        time.format = "[$time]($style) ";
        username.format = "[$user]($style) ";
        username.show_always = true;
        vagrant.format = "[$symbol($version)]($style) ";
        vlang.format = "[$symbol($version)]($style) ";
        zig.format = "[$symbol($version)]($style) ";
        zig.symbol = " ";
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
