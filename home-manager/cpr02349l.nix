{ lib, ... }: {
  home = {
    username = "tneudoerffer";
    homeDirectory = "/home/tneudoerffer";
  };

  programs = {
    alacritty = {
      settings = {
        font.size = lib.mkForce 12;
        shell = "zsh";
        window = lib.mkForce {
          decorations = "None";
        };
      };
    };
    zsh = {
      sessionVariables = {
        SHELL = "zsh";
      };
    };
  };
}
