{ ... }:
{
  virtualisation.oci-containers.containers = {
    freshrss = {
      image = "freshrss/freshrss:latest";
      extraOptions = [ "--pull=always" ];
      autoStart = true;
      volumes = [
        "/volumes/freshrss/data:/var/www/FreshRSS/data"
      ];
      environmentFiles = [ /volumes/freshrss/.env ];
      ports = [
        "8080:80"
      ];
    };
  };
}
