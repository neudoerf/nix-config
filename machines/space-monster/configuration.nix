{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../defaults/vm.nix
    ./../../services/factorio-server.nix
    ./../../services/conduwuit.nix
  ];

  networking = {
    hostName = "space-monster";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [
      27015
    ];
    firewall.allowedUDPPorts = [
      34197
    ];
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
