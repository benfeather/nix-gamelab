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
        "WINGS_USERNAME" = "nixos";
      };

      # environmentFiles = [
      #   config.sops.secrets."cloudflare".path
      # ];

      ports = [
        "2022:2022"
        "8080:8080"
      ];

      # networks = [
      #   "proxy"
      # ];

      volumes = [
        "${env.appdata_dir}/pelican/etc:/etc/pelican"
        "${env.appdata_dir}/pelican/lib:/var/lib/pelican"
        "${env.appdata_dir}/pelican/log:/var/log/pelican"
        "${env.appdata_dir}/pelican/tmp:/tmp/pelican"
        "/etc/ssl/certs:/etc/ssl/certs:ro"
        "/var/lib/docker/containers:/var/lib/docker/containers"
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
    };
  };
}
