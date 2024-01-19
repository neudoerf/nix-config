{ lib, ... }: {
  home = {
    username = "tneudoerffer";
    homeDirectory = "/home/tneudoerffer";
  };

  programs = {
    alacritty = {
      settings = {
        window.decorations = lib.mkForce "full";
      };
    };
    zsh = {
      sessionVariables = {
        SHELL = "zsh";
      };
    };
  };
}
