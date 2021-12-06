{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.issuing-service;

  emitterContractAddress = "0x4b255d6E57409232F7C29759D5699dabE66f8Cd5";
  validatorContractAddress = "0x8a919cC91bA1ac88BF5FdCeb116c35f7Dc1Ed179";

  python-eth_keyfile = pkgs.python3.withPackages (ps : with ps; [ eth-keyfile ]);

in {
  options = {
    services.issuing-service = {
      enable = mkEnableOption "Enable Issuing service.";

      emitter_contract = mkOption {
        type = types.str;
        default = emitterContractAddress;
        description = "Emitter smart-contract address";
      };

      validator = mkOption {
        type = types.str;
        default = validatorContractAddress;
        description = "Validator smart-contract address.";
      };

      lighthouse = mkOption {
        type = types.str;
        default = "0x2442ED30381f8556e1e2C12fdb0E7F0aa56192E9";
        description = "Lighthouse address to work on";
      };

      token = mkOption {
        type = types.str;
        default = "0x7dE91B204C1C737bcEe6F000AAA6569Cf7061cb7";
        description = "Payment token";
      };

      user = mkOption {
        type = types.str;
        default = "liability";
        description = "User account under which service runs.";
      };

    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ issuing_service_agent ];

    systemd.services.erc20 = {
      requires = [ "roscore.service" ];
      after =    [ "roscore.service" "liability.service" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        source ${pkgs.issuing_service_agent}/setup.bash \
          && roslaunch issuing_service_agent issuer.launch \
              emitter_contract:="${cfg.emitter_contract}" \
              validator:="${cfg.validator}" \
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
