{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.liability-nightly;

  mainnetEns = "0x314159265dD8dbb310642f98f50C066173C1259b";
  liabilityHome = "/var/lib/liability";
  keyfile = "${liabilityHome}/keyfile";
  keyfile_password_file = "${liabilityHome}/keyfile-psk";

  python-eth_keyfile = pkgs.python3.withPackages (ps : with ps; [ eth-keyfile setuptools ]);

in {
  options = {
    services.liability-nightly = {
      enable = mkEnableOption "Enable Robonomics liability executor service.";

      graph = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Robonomics telemetry information node.";
      };

      graph_topic = mkOption {
        type = types.str;
        description = "Robonomics PubSub telemetry topic.";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.robonomics_comm-nightly;
        defaultText = "pkgs.robonomics_comm-nightly";
        description = "Robonomics communication stack to use";
      };

      ens = mkOption {
        type = types.str;
        default = mainnetEns;
        description = "Ethereum name regustry address.";
      };

      lighthouse = mkOption {
        type = types.str;
        description = "Lighthouse contract address.";
      };

      factory = mkOption {
        type = types.str;
        description = "Factory contract address.";
      };

      user = mkOption {
        type = types.str;
        default = "liability";
        description = "User account under which service runs.";
      };

      keyfile = mkOption {
        type = types.str;
        default = keyfile;
        description = "Default keyfile for signing messages.";
      };

      keyfile_password_file = mkOption {
        type = types.str;
        default = keyfile_password_file;
        description = "Password file for keyfile.";
      };

      ipfs_http_provider = mkOption {
        type = types.str;
        default = "/ip4/127.0.0.1/tcp/5001/http";
        description = "IPFS http provider address";
      };

      ipfs_public_providers = mkOption {
        type = types.str;
        default = "";
        example = "/dns/ipfs.infura.io/tcp/5001/https";
        description = "list of IPFS public nodes http provider address";
      };

      ipfs_swarm_connect_addresses = mkOption {
        type = types.str;
        default = "";
        example = "/dnsaddr/bootstrap.aira.life, /dns4/1.pubsub.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8";
        description = "list of IPFS bootstrapping nodes";
      };

      web3_http_provider = mkOption {
        type = types.str;
        default = "http://127.0.0.1:8545";
        description = "Web3 http provider address";
      };

      web3_ws_provider = mkOption {
        type = types.str;
        default = "ws://127.0.0.1:8546";
        description = "Web3 websocket provider address";
      };

      ros_master_uri = mkOption {
        type = types.str;
        default = "http://localhost:11311";
        description = "ROS master node location";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.services.liability-nightly = {
      requires = [ "ipfs.service" "roscore.service" ];
      after = [ "ipfs.service" "roscore.service" ];
      wantedBy = [ "multi-user.target" ];

      environment.ROS_MASTER_URI = cfg.ros_master_uri;

      preStart = ''
        if [ ! -e ${cfg.keyfile} ]; then
          ${pkgs.pwgen}/bin/pwgen -1 -s -n 32 > ${cfg.keyfile_password_file}
          ${python-eth_keyfile}/bin/python -c "import os,eth_keyfile,json; print(json.dumps(eth_keyfile.create_keyfile_json(os.urandom(32), open('${cfg.keyfile_password_file}', 'r').readline().rstrip('\n').encode())))" > ${cfg.keyfile}
        fi
      '';

      script = ''
        source ${cfg.package}/setup.bash \
          && roslaunch robonomics_liability liability.launch \
              ens_contract:="${cfg.ens}" \
              lighthouse_contract:="${cfg.lighthouse}" \
              lighthouse_topic:="${cfg.lighthouse}" \
              factory_contract:="${cfg.factory}" \
              keyfile:="${cfg.keyfile}" \
              keyfile_password_file:="${cfg.keyfile_password_file}" \
              ipfs_http_provider:="${cfg.ipfs_http_provider}" \
              ipfs_public_providers:="${cfg.ipfs_public_providers}" \
              ipfs_swarm_connect_addresses:="${cfg.ipfs_swarm_connect_addresses}" \
              web3_http_provider:="${cfg.web3_http_provider}" \
              web3_ws_provider:="${cfg.web3_ws_provider}" \
              enable_aira_graph:="${if cfg.graph then "true" else "false"}" \
              graph_topic:="${cfg.graph_topic}"
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

   users.users = {
      "${cfg.user}" = {
        home = "${liabilityHome}";
        createHome = true;
        isNormalUser = true;
      };
    };
  };
}
