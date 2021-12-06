{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.drone_passport;

  operationalToken = "0x966EbbFD7ECbCF44b1e05341976e0652CFA01360";

in {
  options = {
    services.drone_passport = {
      enable = mkEnableOption "Enable Drone Passport service.";

      login = mkOption {
        type = types.str;
        default = "";
        description = "Email sender login";
      };

      email_from = mkOption {
        type = types.str;
        default = "";
        description = "The value of 'from' field in an email";
      };

      email_password = mkOption {
        type = types.str;
        default = "";
        description = "Email password";
      };

      token = mkOption {
        type = types.str;
        default = operationalToken;
        description = "Operational token";
      };

      pinata_api_key = mkOption {
        type = types.str;
        default = "";
        description = "Pinata.cloud API key";
      };

      pinata_secret_api_key = mkOption {
        type = types.str;
        default = "";
        description = "Pinata.cloud secret API key";
      };

      user = mkOption {
        type = types.str;
        default = "liability";
        description = "User account under which service runs.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ drone_passport_agent ];

    systemd.services.drone_passport = {
      requires = [ "roscore.service"  ];
      after = [ "liability.service" "roscore.service" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        source ${pkgs.drone_passport_agent}/setup.bash \
          && roslaunch drone_passport_agent agent.launch \
              login:="${cfg.login}" \
              email_from:="${cfg.email_from}" \
              email_password:="${cfg.email_password}" \
              token:="${cfg.token}" \
              pinata_api_key:="${cfg.pinata_api_key}" \
              pinata_secret_api_key:="${cfg.pinata_secret_api_key}"
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
