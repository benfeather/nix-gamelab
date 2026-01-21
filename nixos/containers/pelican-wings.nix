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
        "443:443"
        "2022:2022"
      ];

      # networks = [
      #   "proxy"
      # ];

      volumes = [
        "${env.appdata_dir}/pelican/etc:/etc/pelican"
        "${env.appdata_dir}/pelican/lib:/var/lib/pelican"
        "${env.appdata_dir}/pelican/log:/var/log/pelican"
        "${env.appdata_dir}/pelican/tmp:/tmp/pelican"
        "/var/lib/acme/${env.domain}:/etc/letsencrypt"
        "/var/lib/docker/containers:/var/lib/docker/containers"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
    };
  };
}
