{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.sensors_connectivity;
  liabilityHome = "/var/lib/liability";

in {

  options = {
    services.sensors_connectivity = {
      enable = mkEnableOption "Substrate Sensor service";

      package = mkOption {
        type = types.package;
        default = pkgs.sensors-connectivity;
        defaultText = "pkgs.sensors-connectivity";
        description = '' '';
      };

      configFile = mkOption {
        default = "/var/lib/liability/sensors-connectivity.yaml";
        type = with types; nullOr path;
        description = ''patch to configuration file'';
      };
####
      publish_interval = mkOption {
        type = types.int;
        default = 30;
        description = ''time between two published messages'';
      };

      comstation = {
        enable = mkEnableOption "";

        port = mkOption {
          type = types.str;
          default = "/dev/ttyUSB0";
          example = "/dev/ttyS0";
          description = "COM port of the device";
        };

        work_period = mkOption {
          type = types.int;
          default = 300 ;
          description = ''time between two measurements in seconds'';
        };

        geo = mkOption {
          type = types.str;
          default = "";
          example = "53.518568,49.397156";
          description = ''Geo coordinates as latitude,longitude'';
        };

        public_key = mkOption {
          type = types.str;
          default = "";
          example = "90ce1b5acaeb97e70a1e5c11ba1bc11982c5351a53660010c0e7f7043263cbf5";
          description = ''If not provided, COMStation creates itself'';
        };
      };

      tcpstation = {
        enable = mkEnableOption "";

        address = mkOption {
          type = types.str;
          default = "0.0.0.0:31313";
          description = ''IP and PORT to listen to, 0.0.0.0:31313 means available for everyone'';
        };

        acl = mkOption {
          type = types.str;
          default = "";
          description = ''list of known addresses. If not specified accepts from everyone'';
        };
      };

      httpstation = {
        enable = mkEnableOption "";

        port= mkOption {
          type = types.int;
          default = 8001;
          description = '''';
        };
      };

      luftdaten = mkEnableOption "whether or not publish to https://luftdaten.info/";

      robonomics = {
        enable = mkEnableOption "";

        ipfs_provider= mkOption {
          type = types.str;
          default = "/ip4/127.0.0.1/tcp/5001/http";
          example = "/ip4/127.0.0.1/tcp/5001/http";
          description = ''ipfs endpoint'';
        };

        ipfs_topic= mkOption {
          type = types.str;
          default = "airalab.lighthouse.5.robonomics.eth";
          example = "airalab.lighthouse.5.robonomics.eth";
          description = ''airalab.lighthouse.5.robonomics.eth'';
        };
      };

      datalog = {
        enable = mkEnableOption "";

        path= mkOption {
          default = "${pkgs.substrate-node-robonomics-bin}/bin/robonomics";
          type = with types; nullOr path;
          description = ''path to Robonomics execution file'';
        };

        suri = mkOption {
          type = types.str;
          default = "";
          example = "0x7c55cad1d39663a4be66785826e08008108938c24a3301127176bb18712ad4bd";
          description = ''private key of publisher account'';
        };

        remote =  mkOption {
          type = types.str;
          default = "wss://substrate.ipci.io";
          example = "wss://substrate.ipci.io";
          description = ''websocket substrate endpoint'';
        };

        dump_interval = mkOption {
          type = types.int;
          default = 3600;
          description = ''time between two transactions in seconds'';
        };

        temporal_username = mkOption {
          type = types.str;
          default = "";
          description = ''Temporal.Cloud credentials'';
        };

        temporal_password = mkOption {
          type = types.str;
          default = "";
          description = ''Temporal.Cloud credentials'';
        };
      };

      sentry =  mkOption {
        type = types.str;
        default = "";
        description = ''sentry.io api key'';
      };
####
      user = mkOption {
        type = types.str;
        default = "liability";
        description = "User account under which substrate node robonomics runs";
      };

      group = mkOption {
        type = types.str;
        default = "users";
        description = "Group under which substrate node robonomics user";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    systemd.services.sensors_connectivity = {
      requires = [ "ipfs.service"  "roscore.service" ];
      after = [ "ipfs.service" "roscore.target" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        source ${cfg.package}/setup.bash \
        && roslaunch sensors_connectivity agent.launch config:="${toString cfg.configFile}"
      '';

      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
        User = cfg.user;
        Group = cfg.group;
      };
    };
    users.users = {
      "${cfg.user}" = {
        home = "${liabilityHome}";
        createHome = true;
        isNormalUser = true;
      };
    };
  };
}
