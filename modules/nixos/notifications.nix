{ lib, ... }: {
  flake.modules.nixos.notifications = { pkgs, lib, config, ... }:
  let
    usernames = config.yorha.notifications.usernames;
  in {
    options.yorha.notifications = {
      usernames = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "yusa" ];
        description = "List of usernames for desktop notifications";
      };
    };

    config = {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "notify-user" ''
          NOTIFY="${pkgs.libnotify}/bin/notify-send"
          for user in ${lib.concatStringsSep " " usernames}; do
            uid=$(id -u "$user" 2>/dev/null || echo 1000)
            bus_path="/run/user/$uid/bus"
            if [ -S "$bus_path" ]; then
              sudo -u "$user" DBUS_SESSION_BUS_ADDRESS="unix:path=$bus_path" \
                "$NOTIFY" -u "''${1:-normal}" -t "''${4:-15000}" "''${2:-Notification}" "''${3:-}" 2>/dev/null || true
            fi
          done
        '')
      ];
    };
  };
}
