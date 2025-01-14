{ pkgs, ... }:
let
  iosevka-neudoerf = pkgs.iosevka.override {
    privateBuildPlan = builtins.readFile ./iosevka-neudoerf/iosevka-neudoerf.toml;
    set = "Neudoerf";
  };
in
{
  fonts.fontconfig.enable = true;
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      alacritty-theme
      ghostty
      wezterm

      # fonts
      iosevka-neudoerf
      nerd-fonts.caskaydia-mono
      nerd-fonts.iosevka
      nerd-fonts.monaspace
      nerd-fonts.zed-mono
    ];
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        import = [ "${pkgs.alacritty-theme}/tokyo-night.toml" ];
        font = {
          normal.family = "IosevkaNeudoerf Nerd Font";
          size = 14;
        };
        window = {
          dynamic_padding = true;
          decorations = "buttonless";
          option_as_alt = "Both";
        };
        cursor.style.shape = "Underline";
      };
    };
    neovide = {
      enable = true;
      settings = { fork = true; };
    };
  };
}
