{ lib, ... }: {
  flake.modules.nixos.odysseus = { pkgs, lib, config, ... }: {
    options.yorha.modules.odysseus = {
      enable = lib.mkEnableOption "Odysseus self-hosted AI workspace";

      username = lib.mkOption {
        type = lib.types.str;
        default = "yusa";
        description = "Primary username for docker group membership";
      };

      bind = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1";
        description = "Bind address for Odysseus web UI";
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 7000;
        description = "Port for Odysseus web UI";
      };

      dataDir = lib.mkOption {
        type = lib.types.str;
        default = "/var/lib/odysseus";
        description = "Persistent data directory for Odysseus";
      };

      dockerNAT = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Set up nftables NAT masquerade for Docker bridge internet access";
      };

      source = lib.mkOption {
        type = lib.types.package;
        default = pkgs.fetchFromGitHub {
          owner = "pewdiepie-archdaemon";
          repo = "odysseus";
          rev = "1c9623a81d63a1ec4d28bef54082e6b1d3766eb6";
          hash = "sha256-83NEsm4MBw8aY2oXpzZSZ/fcx9toTGRAE89+NE0Vw+w=";
        };
        description = "Odysseus source tree (flake input or fetchFromGitHub)";
      };
    };

    config = lib.mkIf config.yorha.modules.odysseus.enable {
      virtualisation.docker.enable = true;
      virtualisation.docker.daemon.settings = lib.mkIf config.yorha.modules.odysseus.dockerNAT {
        iptables = false;
        bridge = "odysseus0";
      };

      users.users.${config.yorha.modules.odysseus.username}.extraGroups = [ "docker" ];

      environment.systemPackages = with pkgs; [
        docker-compose
      ];

      systemd.services.docker-bridge-nat = lib.mkIf config.yorha.modules.odysseus.dockerNAT {
        description = "Docker Bridge NAT Masquerade";
        after = [ "network.target" "docker.service" ];
        bindsTo = [ "docker.service" ];
        wantedBy = [ "multi-user.target" ];
        script = ''
          ${pkgs.nftables}/bin/nft add table ip nat 2>/dev/null || true
          ${pkgs.nftables}/bin/nft add chain ip nat POSTROUTING '{ type nat hook postrouting priority srcnat; policy accept; }' 2>/dev/null || true
          ${pkgs.nftables}/bin/nft flush chain ip nat POSTROUTING 2>/dev/null || true
          ${pkgs.nftables}/bin/nft add rule ip nat POSTROUTING ip saddr 172.16.0.0/12 oifname != "docker0" masquerade
        '';
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
      };

      systemd.services.odysseus = {
        description = "Odysseus Self-Hosted AI Workspace";
        after = [ "docker.service" ] ++ lib.optional config.yorha.modules.odysseus.dockerNAT "docker-bridge-nat.service"
          ++ [ "network-online.target" ];
        wants = [ "docker.service" "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        path = with pkgs; [ docker docker-compose git ];

        script = ''
          SRC="${config.yorha.modules.odysseus.source}"
          DATA_DIR="${config.yorha.modules.odysseus.dataDir}"

          mkdir -p "$DATA_DIR"/{data,logs,config/searxng,ssh}

          if [ ! -f "$DATA_DIR/docker-compose.yml" ]; then
            cp -rT "$SRC" "$DATA_DIR/source" 2>/dev/null || true
            for f in docker-compose.yml Dockerfile .dockerignore requirements.txt requirements-optional.txt setup.py pyproject.toml; do
              [ -f "$SRC/$f" ] && cp "$SRC/$f" "$DATA_DIR/" 2>/dev/null || true
            done
            [ -d "$SRC/docker" ] && cp -r "$SRC/docker" "$DATA_DIR/" 2>/dev/null || true
            [ -d "$SRC/config/searxng" ] && cp -r "$SRC/config/searxng" "$DATA_DIR/config/" 2>/dev/null || true
          fi

          if [ ! -f "$DATA_DIR/config/searxng/settings.yml" ] && [ -f "$SRC/config/searxng/settings.yml" ]; then
            cp "$SRC/config/searxng/settings.yml" "$DATA_DIR/config/searxng/"
          fi

          if [ ! -f "$DATA_DIR/.env" ]; then
            cp "$SRC/.env.example" "$DATA_DIR/.env"
            echo "Created default .env — edit $DATA_DIR/.env to customize"
          fi

          cd "$DATA_DIR"
          docker compose up -d
        '';

        preStop = ''
          cd ${config.yorha.modules.odysseus.dataDir}
          docker compose down 2>/dev/null || true
        '';

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          TimeoutStartSec = 300;
          TimeoutStopSec = 60;
          Restart = "no";
        };
      };
    };
  };
}
