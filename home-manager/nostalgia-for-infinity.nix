{ pkgs, ... }: {
  home = {
    username = "neudoerf";
    homeDirectory = "/Users/neudoerf";
    packages = [
      pkgs.poetry
      (pkgs.python312.withPackages (p: [
        p.filterpy
        p.jupyter
        p.scipy
        p.sympy
      ]))
    ];
    sessionVariables = {
      NEOVIDE_FRAME = "buttonless";
    };
  };
}
