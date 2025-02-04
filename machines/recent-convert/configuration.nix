# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../defaults/vm.nix
    ./../../services/homepage.nix
    ./../../services/factorio-server.nix
    ./../../services/forgejo.nix
    ./../../services/freshrss.nix
  ];

  networking = {
    hostName = "recent-convert";
    networkmanager.enable = true;
    firewall.enable = false;
    # firewall.allowedUDPPorts = [
    #   34197 # factorio
    # ];
    # firewall.allowedTCPPorts = [
    #   27015 # factorio
    # ];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
