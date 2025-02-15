{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../defaults/vm.nix
    ./../../services/factorio-server.nix
  ];

  networking = {
    hostName = "within-reason";
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
