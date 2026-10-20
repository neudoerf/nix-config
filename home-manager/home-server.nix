{ pkgs, ... }:
{
  home = {
    stateVersion = "23.11";
    packages = with pkgs; [
      bat
      curl
      dust
      fd
      htop
      jq
      lazygit
      ripgrep
      tmux
    ];
  };

  xdg.configFile."tmux/tmux.conf".source = ./tmux/tmux.conf;

  programs = {
    atuin = {
      enable = true;
      enableFishIntegration = true;
      settings.enter_accept = true;
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-night";
        vim_keys = true;
      };
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
    };
    fish = {
      enable = true;
      shellAliases = {
        PAGER = "bat";
        cat = "bat";
      };
      shellInit = "set fish_greeting";
    };
    fzf.enable = true;
    git = {
      enable = true;
      settings = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
        user = {
          email = "tom@neudoerffer.com";
          name = "Tom Neudoerffer";
        };
      };
    };
    home-manager.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
