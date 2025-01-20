{...}: {
  virtualisation.oci-containers.containers = {
    caddy = {
      image = "ghcr.io/neudoerf/caddy-cloudflare:latest";
      autoStart = true;
      user = "1000:100";
      volumes = [
        "/volumes/caddy/Caddyfile:/etc/caddy/Caddyfile"
        "/volumes/caddy/data:/data"
        "/volumes/caddy/config:/config"
      ];
      environmentFiles = [/volumes/caddy/.env];
      ports = ["80:80" "443:443"];
    };
  };
}
