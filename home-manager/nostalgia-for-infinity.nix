{ pkgs, ... }: {
  home = {
    username = "neudoerf";
    homeDirectory = "/Users/neudoerf";
    packages = [ pkgs.poetry ];
  };
  programs = {
    zsh.sessionVariables.NEOVIDE_FRAME = "buttonless";
  };
}
