{ ... }:
{
  virtualisation.oci-containers.containers = {
    conduwuit = {
      image = "ghcr.io/girlbossceo/conduwuit:latest";
      extraOptions = [ "--pull=always" ];
      autoStart = true;
      volumes = [
        "/volumes/conduwuit/db:/var/lib/conduwuit"
        "/volumes/conduwuit/conduwuit.toml:/etc/conduwuit/conduwuit.toml"
      ];
      environmentFiles = [ /volumes/conduwuit/.env ];
      ports = [
        "8448:6167"
      ];
    };
  };
}
