{ ... }:
{
  virtualisation.oci-containers.containers = {
    homepage = {
      image = "ghcr.io/gethomepage/homepage:latest";
      extraOptions = [ "--pull=always" ];
      autoStart = true;
      user = "1000:100";
      volumes = [
        "/volumes/homepage/config:/app/config"
      ];
      ports = [
        "3000:3000"
      ];
    };
  };
}
