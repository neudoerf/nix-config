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
          padding = {
            x = 5;
            y = 5;
          };
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
