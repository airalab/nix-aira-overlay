{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.substrate_sensor;

in {

  options = {
    services.substrate_sensor = {
      enable = mkEnableOption "Substrate Sensor service";

      package = mkOption {
        type = types.package;
        default = pkgs.substrate_sensor_demo;
        defaultText = "pkgs.substrate_sensor_demo";
        description = '' '';
      };

      interval = mkOption {
        type = types.int;
        default = 30;
        description = "Interval in seconds";
      };

      port = mkOption {
        type = types.str;
        default = "/dev/ttyS0";
        description = "The port where the sensor is";
      };

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

    systemd.services.substrate_sensor = {
      requires = [ "ipfs.service"  "roscore.service" ];
      after = [ "ipfs.service" "roscore.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = concatStringsSep " " [
          ''${pkgs.bash}/bin/bash -c "source ${cfg.package}/setup.bash &&''
          ''roslaunch substrate_sensor_demo agent.launch interval:=${toString cfg.interval} port:='${cfg.port}'" "''
        ];
        User = cfg.user;
        Group = cfg.group;
      };
    };
  };
}
