{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../defaults/vm.nix
    ./../../services/caddy.nix
  ];

  networking = {
    hostName = "within-reason";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
