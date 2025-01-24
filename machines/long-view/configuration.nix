{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../defaults/vm.nix
    ./../../services/caddy.nix
  ];

  networking = {
    hostName = "long-view";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
