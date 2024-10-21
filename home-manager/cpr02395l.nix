{ lib, pkgs, ... }:
{
  home = {
    username = "tneudoerffer";
    homeDirectory = "/home/tneudoerffer";
    packages =
      [
        pkgs.cider
        pkgs.iosevka-comfy.comfy-fixed
        pkgs.iosevka-comfy.comfy-duo
        pkgs.poetry
        pkgs.wl-clipboard
      ];
    sessionVariables = {
      NEOVIDE_FRAME = "none";
      SHELL = "/bin/bash";
    };
  };

  programs = {
    alacritty = {
      settings = {
        env.TERM = "xterm-256color";
        font.size = lib.mkForce 12;
        shell = "fish";
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
        default_shell = "fish";
      };
    };
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;
}
