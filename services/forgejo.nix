{ ... }:
{
  virtualisation.oci-containers.containers = {
    forgejo = {
      image = "codeberg.org/forgejo/forgejo:10";
      extraOptions = [ "--pull=always" ];
      autoStart = true;
      volumes = [
        "/volumes/forgejo/data:/data"
        "/etc/localtime:/etc/localtime:ro"
      ];
      environment = {
        "USER_UID" = "1000";
        "USER_GID" = "100";
      };
      ports = [
        "3001:3000"
        "222:22"
      ];
    };
  };
}
