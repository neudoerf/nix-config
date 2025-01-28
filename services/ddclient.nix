{ ... }:
{
  virtualisation.oci-containers.containers = {
    ddclient = {
      image = "lscr.io/linuxserver/ddclient:latest";
      extraOptions = [ "--pull=always" ];
      autoStart = true;
      user = "1000:100";
      volumes = [
        "/volumes/ddclient/config:/config"
      ];
      environmentFiles = [ /volumes/ddclient/.env ];
      ports = [ ];
    };
  };
}
