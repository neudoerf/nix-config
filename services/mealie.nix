{ ... }:
{
  virtualisation.oci-containers.containers = {
    mealie = {
      image = "ghcr.io/mealie-recipes/mealie";
      extraOptions = [
        "--pull=always"
        "--memory=1g"
      ];
      autoStart = true;
      volumes = [
        "/volumes/mealie/data:/app/data"
      ];
      environmentFiles = [ /volumes/mealie/.env ];
      ports = [
        "9925:9000"
      ];
    };
  };
}
