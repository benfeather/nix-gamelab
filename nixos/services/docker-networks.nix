{
  pkgs,
  ...
}:
{
  systemd.services.docker-networks = {
    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      ${pkgs.docker}/bin/docker network inspect tunnel || \
      ${pkgs.docker}/bin/docker network create --driver="bridge" tunnel
    '';

    wantedBy = [
      "docker-cf-tunnel.service"
      "docker-pelican-wings.service"
    ];
  };
}
