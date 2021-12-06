{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.drone_flight_report;

  operationalToken = "0x7dE91B204C1C737bcEe6F000AAA6569Cf7061cb7";

in {
  options = {
    services.drone_flight_report = {
      enable = mkEnableOption "Enable Drone Flight Report service.";

      lighthouse = mkOption {
        type = types.str;
        default = "0xA02500497E5163DbC049453509Fae8C9825cf18e";
        description = "Lighthouse to work on";
      };

      token = mkOption {
        type = types.str;
        default = operationalToken;
        description = "Operational token";
      };

      user = mkOption {
        type = types.str;
        default = "liability";
        description = "User account under which service runs.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ drone_flight_report ];

    systemd.services.drone_passport = {
      requires = [ "roscore.service"  ];
      after = [ "liability.service" "roscore.service" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        source ${pkgs.drone_flight_report}/setup.bash \
          && roslaunch drone_flight_report agent.launch \
              lighthouse:="${cfg.lighthouse}" \
              token:="${cfg.token}"
      '';

      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 60;
        User = cfg.user;
      };
      unitConfig = {
        StartLimitIntervalSec = 0;
        StartLimitBurst = 3;
      };
    };
  };
}
