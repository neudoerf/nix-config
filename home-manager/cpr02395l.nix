{ lib, pkgs, ... }:
let
  alacritty-bin = pkgs.writeScriptBin "alacritty-bin" ''
    #!/bin/sh
    exec ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.alacritty}/bin/alacritty
  '';
  alacritty-desktop = pkgs.makeDesktopItem
    {
      type = "Application";
      name = "nixGL Alacritty";
      desktopName = "nixGL Alacritty";
      exec = "${alacritty-bin}/bin/alacritty-bin %U";
      genericName = "Terminal";
      icon = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/logo/alacritty-term.svg";
        sha256 = "sha256:1ljxxdljj76a3vqldzssjg5j45ljazk7ismci4cd5ikyvb89m3b5";
      };
    };
  wezterm-desktop = pkgs.makeDesktopItem {
    type = "Application";
    name = "nixGL Wezterm";
    desktopName = "nixGL Wezterm";
    exec = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.wezterm}/bin/wezterm %U";
    genericName = "Terminal";
    icon = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/wez/wezterm/main/assets/icon/wezterm-icon.svg";
      sha256 = "sha256:06syx1ps2vx1zf5icgl8n238nsm51axw0x145rn8g6pb8ayc3sb9";
    };
  };
in
{
  home = {
    username = "tneudoerffer";
    homeDirectory = "/home/tneudoerffer";
    packages =
      [
        alacritty-desktop
        wezterm-desktop
        pkgs.cider
        pkgs.nixgl.nixGLIntel
        pkgs.iosevka-comfy.comfy-fixed
        pkgs.iosevka-comfy.comfy-duo
        pkgs.poetry
        pkgs.wl-clipboard
      ];
  };

  programs = {
    alacritty = {
      settings = {
        env.TERM = "xterm-256color";
        font.size = lib.mkForce 12;
        shell = "zsh";
        window = lib.mkForce {
          decorations = "None";
          padding = {
            x = 12;
            y = 12;
          };
        };
      };
    };
    git.userEmail = lib.mkForce "tneudoerffer@ottomotors.com";
    zellij = {
      settings = {
        default_shell = "zsh";
      };
    };
    zsh.sessionVariables.NEOVIDE_FRAME = "none";
    zsh.sessionVariables.SHELL = "/bin/bash";
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
}
