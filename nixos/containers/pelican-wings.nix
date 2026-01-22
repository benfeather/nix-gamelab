{
  config,
  env,
  ...
}:
{
  virtualisation.oci-containers.containers = {
    "pelican-wings" = {
      image = "ghcr.io/pelican-dev/wings:latest";
      hostname = "pelican-wings";

      environment = {
        "TZ" = env.tz;
        "WINGS_UID" = env.puid;
        "WINGS_GID" = env.pgid;
      };

      ports = [
        "2022:2022"
        "8080:8080"
      ];

      networks = [
        "tunnel"
        "pelican_nw"
      ];

      volumes = [
        "/etc/pelican:/etc/pelican"
        "/tmp/pelican:/tmp/pelican"
        "/var/lib/acme/${env.domain}:/etc/letsencrypt"
        "/var/lib/docker/containers:/var/lib/docker/containers"
        "/var/lib/pelican:/var/lib/pelican"
        "/var/log/pelican:/var/log/pelican"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
    };
  };
}
