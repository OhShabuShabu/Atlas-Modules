# ============================================================================
# notifications.nix — Shared notification script for security modules
# ============================================================================
# Writes a notify-user script that sends desktop notifications over DBUS.
# Used by security modules to alert the user of security events.
# ============================================================================
{ config, pkgs, lib, ... }:

let
  cfg = config.atlas.notifications;
in {
  options.atlas.notifications = {
    username = lib.mkOption {
      type = lib.types.str;
      default = "yusa";
      description = "Primary username for desktop notifications";
    };
  };

  config = {
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "notify-user" ''
        NOTIFY="${pkgs.libnotify}/bin/notify-send"
        for user in "${cfg.username}"; do
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
}
