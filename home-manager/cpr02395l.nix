{ lib, pkgs, ... }:
{
  home = {
    username = "tneudoerffer";
    homeDirectory = "/home/tneudoerffer";
    packages = with pkgs; [
      cider
      iosevka-comfy.comfy-fixed
      iosevka-comfy.comfy-duo
      obsidian
      poetry
      wl-clipboard
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
