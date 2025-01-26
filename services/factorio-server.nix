{ ... }:
{
  virtualisation.oci-containers.containers = {
    factorio-server = {
      image = "factoriotools/factorio";
      extraOptions = [ "--pull=always" ];
      autoStart = true;
      volumes = [
        "/volumes/factorio/data:/factorio"
      ];
      environmentFiles = [ /volumes/factorio/.env ];
      ports = [
        "34197:34197/udp"
        "27015:27015"
      ];
    };
  };
}
