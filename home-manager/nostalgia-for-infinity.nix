{ pkgs, ... }: {
  home = {
    username = "neudoerf";
    homeDirectory = "/Users/neudoerf";
    packages = [ pkgs.poetry ];
    sessionVariables = {
      NEOVIDE_FRAME = "buttonless";
    };
  };
}
