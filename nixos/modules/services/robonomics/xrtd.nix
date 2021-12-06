{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.xrtd;

in {
  options = {
    services.xrtd = {
      enable = mkEnableOption "Robonomics.network provider daemon.";

      keyfile = mkOption {
        type = types.str;
        description = "Hex encoded private key file";
      };

      web3_provider = mkOption {
        type = types.str;
        default = "";
        description = "Web3 provider URI";
      };

      ipfs_provider = mkOption {
        type = types.str;
        default = "";
        description = "IPFS provider multiaddress";
      };

      lighthouse = mkOption {
        type = types.str;
        default = "";
        description = "Lighthouse ENS";
      };

      factory = mkOption {
        type = types.str;
        default = "";
        description = "Factory ENS";
      };

      chain = mkOption {
        type = types.str;
        default = "";
        description = "CHAIN_ID: Ethereum chain [foundation, ropsten, kovan, rikenby]";
      };

      ens = mkOption {
        type = types.str;
        default = "";
        description = "ENS registry address";
      };

      local = mkOption {
        type = types.bool;
        default = false;
        description = "XRTd local mode (mining)";
      };

      gasprice = mkOption {
        type = types.int or (types.enum [ "safe" "fast" "fastest" ]);
        default = "safe";
        description = "Transaction sending gas price";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.xrtd = {
      requires = [ "ipfs.service" ];
      after = [ "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];

      path = with pkgs; [ bash getent ipfs ];

      script = ''
        ${pkgs.robonomics-tools}/bin/xrtd --private "$(cat ${cfg.keyfile})" ${optionalString (cfg.web3_provider != "") "--web3 \"${cfg.web3_provider}\""} ${optionalString (cfg.ipfs_provider != "") "--ipfs \"${cfg.ipfs_provider}\""} ${optionalString (cfg.lighthouse != "") "--lighthouse \"${cfg.lighthouse}\""} ${optionalString (cfg.ens != "") "--ens \"${cfg.ens}\""} ${optionalString (cfg.factory != "") "--factory \"${cfg.factory}\""} ${optionalString (cfg.chain != "") "--chain \"${cfg.chain}\""} ${optionalString cfg.local "-l"} --gasprice ${toString cfg.gasprice}
      '';

      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
