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
in
{
  home = {
    username = "tneudoerffer";
    homeDirectory = "/home/tneudoerffer";
    packages =
      (with pkgs.nixgl; [ nixGLIntel ]) ++ [ alacritty-desktop ];
  };

  programs = {
    alacritty = {
      settings = {
        font.size = lib.mkForce 12;
        shell = "zsh";
        window = lib.mkForce {
          decorations = "None";
          padding = {
            x = 5;
            y = 5;
          };
        };
      };
    };
    zellij = {
      settings = {
        default_shell = "zsh";
      };
    };
  };
}
