{ pkgs, ... }:
{
  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 0;
  };

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  programs.fish.enable = true;

  users.users.neudoerf = {
    isNormalUser = true;
    description = "Tom Neudoerffer";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyPIcsMhs7ArU4sdxwoI9RxUP0o69UDXZ8b4X/iPeJf"
    ];
    shell = pkgs.fish;
  };

  nix = {
    settings = {
      # List packages installed in system profile. To search, run:
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      min-free = 5368709120;

      trusted-public-keys = [
        "size-isnt-everything:VqlkSjMoUZsoudCjK3Lz3mtaPoI3YIoKmGbKLDVaEWg="
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  virtualisation.containers.enable = true;

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    qemuGuest.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

}
