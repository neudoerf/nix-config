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
    sessionPath = [
      "/Users/neudoerf/.cargo/bin"
    ];
    sessionVariables = {
      NEOVIDE_FRAME = "buttonless";
    };
  };
}
