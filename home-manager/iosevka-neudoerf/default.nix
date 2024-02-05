{ pkgs, stdenv, python3Packages, fetchFromGitHub }:

let
  iosevka-neudoerf = pkgs.iosevka.override {
    privateBuildPlan = builtins.readFile ./iosevka-neudoerf.toml;
    set = "neudoerf";
  };

  version = "3.1.1";
  src = fetchFromGitHub {
    owner = "ryanoasis";
    repo = "nerd-fonts";
    rev = "v${version}";
    sparseCheckout = [
      "font-patcher"
      "src/"
      "bin/"
      "!src/unpatched-fonts/"
    ];
    sha256 = "sha256-dwjs4tKU1TUBEvOlPk8y711STnHBCFU8I6TIq12PLIs=";
  };
in
stdenv.mkDerivation {
  inherit version src iosevka-neudoerf;
  name = "iosevka-neudoerf";

  nativeBuildInputs = with python3Packages; [
    python
    fontforge
  ];

  # Custom build plan
  buildPhase = ''
    mkdir -p $out/share/fonts/opentype
    for f in ${iosevka-neudoerf}/share/fonts/truetype/*; do
      python font-patcher $f --complete --no-progressbars --outputdir $out/share/fonts/truetype
    done
  '';

  dontInstall = true;
  dontFixup = true;
}
