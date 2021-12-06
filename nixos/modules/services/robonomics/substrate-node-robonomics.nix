{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.substrate-node-robonomics;
  varDir = "/var/lib/substrate-node-robonomics";

in {

  options = {
    services.substrate-node-robonomics = {
      enable = mkEnableOption "Substrate node robonomics daemon.";

      package = mkOption {
        type = types.package;
        default = pkgs.substrate-node-robonomics-bin;
        defaultText = "pkgs.substrate-node-robonomics-bin";
        description = ''
          Substrate node robonomics package
          [possible values: pkgs.substrate-node-robonomics, pkgs.substrate-node-robonomics-bin]
       '';
      };

      name = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          The human-readable name for this node, as reported to the telemetry server, if enabled
        '';
      };

      listen-addr = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Listen on this multiaddress
        '';
      };

      port = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Specify p2p protocol TCP port. Only used if --listen-addr is not specified.
        '';
      };

      rpc-port = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Specify HTTP RPC server TCP port
        '';
      };

      rpc-cors = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Specify browser Origins allowed to access the HTTP and WS RPC servers. It's a comma-separated list of origins
          (protocol://domain or special `null` value). Value of `all` will disable origin validation. Default is to
          allow localhost, https://polkadot.js.org and https://substrate-ui.parity.io origins. When running in --dev
          mode the default is to allow all origins.
        '';
      };

      ws-port = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Specify WebSockets RPC server TCP port
        '';
      };
      ws-max-connections = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Maximum number of WS RPC server connections.
        '';
      };

      reserved-nodes = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Specify a list of reserved node addresses
        '';
      };

      telemetry-url = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = '' The URL of the telemetry server to connect to. 
          This flag can be passed multiple times as a mean to specify 
          multiple telemetry endpoints. Verbosity levels range from 0-9, with 0 
          denoting the least verbosity. If no verbosity level is specified the default is 0.
        '';
      };

      in-peers = mkOption {
        type = types.nullOr types.int;
        default = null; description = ''
          Specify the maximum number of incoming connections we're accepting
          [default: 25]
        '';
      };

      out-peers = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Specify the number of outgoing connections we're trying to maintain
          [default: 25]
        '';
      };

      pool-kbytes = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Maximum number of kilobytes of all transactions stored in the pool.
          [default: 10240]
        '';
      };

      pool-limit = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Maximum number of transactions in the transaction pool.
          [default: 512]
        '';
      };

      pruning = mkOption {
        type = types.either types.int (types.enum [ "archive" ]);
        default = 256; 
        description = ''
          Specify the pruning mode, a number of blocks to keep or 'archive'. Default is 256.
        '';
      };

      base-path = mkOption {
        type = types.path;
        default = varDir;
        description = ''
          [default: /var/lib/substrate-node-robonomics]
        '';
      };

      keystore-path = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = ''
          Specify custom keystore path.
        '';
      };

      password = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Password used by the keystore.
        '';
      };
      password-filename = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = ''
          File that contains the password used by the keystore.
        '';
      };

      node-key = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          The secret key to use for libp2p networking.
        '';
      };

      node-key-type = mkOption {
        type = types.nullOr (types.enum [ "Secp256k1" "Ed25519" ]);
        default = null;
        example = "Ed25519";
        description = ''
          The current default key type is `secp256k1` for a transition period only but will eventually change to
          `ed25519` in a future release. To continue using `secp256k1` keys, use `--node-key-type=secp256k1`.
          [default: Ed25519]
          [possible values: Secp256k1, Ed25519]
        '';
      };

      node-key-file = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = ''
         If the `--node-key-file` option is given, the secret key is read from the specified file. See the
         documentation for `--node-key-file`.
        '';
      };

      log = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Sets a custom logging filter
        '';
      };

      db-cache = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Limit the memory the database cache can use MiB
        '';
      };

      chain = mkOption {
        type = types.nullOr (types.enum [ "dev" "local" "staging" ]);
        default = null;
        example = "dev";
        description = ''
        Specify the chain specification (one of dev, local or staging)
        '';
      };

      state-cache-size = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''
          Specify the state cache size
          [default: 67108864]
        '';
      };

     offchain-worker = mkOption {
        type = types.nullOr (types.enum [ "Always" "Never" "WhenValidating" ]);
        default = null;
        example = "WhenValidating";
        description = ''
          Should execute offchain workers on every block. By default it's only enabled for nodes that are authoring new blocks.
          [default: WhenValidating]
          [possible values: Always, Never, WhenValidating]
        '';
      };
 
     execution = mkOption {
        type = types.nullOr (types.enum [ "Native" "Wasm" "Both" "NativeElseWasm" ]);
        default = null;
        example = "Native";
        description = ''
          The execution strategy that should be used by all execution contexts.
          [possible values: Native, Wasm, Both, NativeElseWasm]
        '';
      };
      execution-block-construction = mkOption {
        type = types.nullOr (types.enum [ "Native" "Wasm" "Both" "NativeElseWasm" ]);
        default = null;
        example = "Native";
        description = ''
          The means of execution used when calling into the runtime while constructing blocks.
          [default: Wasm]
          [possible values: Native, Wasm, Both, NativeElseWasm]
        '';
      };
      execution-import-block = mkOption {
        type = types.nullOr (types.enum [ "Native" "Wasm" "Both" "NativeElseWasm" ]);
        default = null;
        example = "Native";
        description = ''
          The means of execution used when calling into the runtime while importing blocks.
          [default: NativeElseWasm]
          [possible values: Native, Wasm, Both, NativeElseWasm]
        '';
      };
      execution-offchain-worker = mkOption {
        type = types.nullOr (types.enum [ "Native" "Wasm" "Both" "NativeElseWasm" ]);
        default = null;
        example = "Native";
        description = ''
          The means of execution used when calling into the runtime while using an off-chain worker. 
          [default: Native]
          [possible values: Native, Wasm, Both, NativeElseWasm]
        '';
      };
      execution-other = mkOption {
        type = types.nullOr (types.enum [ "Native" "Wasm" "Both" "NativeElseWasm" ]);
        default = null;
        example = "Native";
        description = ''
          The means of execution used when calling into the runtime while not syncing, importing or constructing blocks. 
          [default: Native]
          [possible values: Native, Wasm, Both, NativeElseWasm]
        '';
      };
      execution-syncing = mkOption {
        type = types.nullOr (types.enum [ "Native" "Wasm" "Both" "NativeElseWasm" ]);
        default = null;
        example = "Native";
        description = ''
          The means of execution used when calling into the runtime while syncing blocks.
          [default: NativeElseWasm]
          [possible values: Native, Wasm, Both, NativeElseWasm]
        '';
      };

      validator = mkOption {
        type = types.bool;
        default = false;
        description = ''
        '';
      };

      grafana-external = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Listen to all Grafana data source interfaces
        '';
      };

      grafana-port = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = ''  
          Specify Grafana data source server TCP Port.
        '';
      };

      user = mkOption {
        type = types.str;
        default = "substrate-node-robonomics";
        description = "User account under which substrate node robonomics runs";
      };

      group = mkOption {
        type = types.str;
        default = "robonomics";
        description = "Group under which substrate node robonomics user";
      };
    };
  };

  config = mkIf cfg.enable {
    users = {
      users = mkIf (cfg.user == "substrate-node-robonomics") {
        substrate-node-robonomics = {
          group = cfg.group;
          home = varDir;
          createHome = true;
          uid = config.ids.uids.substrate-node-robonomics;
          description = "substrate node robonomics daemon user";
        };
      };
      groups = mkIf (cfg.group == "robonomics") {
        robonomics.gid = config.ids.gids.robonomics;
      };
    };

    systemd.services.substrate-node-robonomics = {
      requires = [ "network.target" ];
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = concatStringsSep " " [
          ''${cfg.package}/bin/robonomics''
          ''--base-path ${cfg.base-path}''
          ''${optionalString (cfg.keystore-path != null) "--keystore-path ${cfg.keystore-path}"}''
          ''${optionalString (cfg.password != null) "--password ${cfg.password}"}''
          ''${optionalString (cfg.password-filename != null) "--password-filename ${cfg.password-filename}"}''
          ''${optionalString (cfg.db-cache != null) "--db-cache ${toString cfg.db-cache}"}''
          ''${optionalString (cfg.chain != null) "--chain ${cfg.chain}"}''
          ''${optionalString (cfg.state-cache-size != null) "--state-cache-size ${toString cfg.state-cache-size}"}''
          ''${optionalString (cfg.execution-block-construction != null) "--execution-block-construction ${cfg.execution-block-construction}"}''
          ''${optionalString (cfg.execution-import-block != null) "--execution-import-block ${cfg.execution-import-block}"}''
          ''${optionalString (cfg.execution-offchain-worker != null) "--execution-offchain-worker ${cfg.execution-offchain-worker}"}''
          ''${optionalString (cfg.execution-other != null) "--execution-other ${cfg.execution-other}"}''
          ''${optionalString (cfg.execution-syncing != null) "--execution-syncing  ${cfg.execution-syncing}"}''
          ''${optionalString (cfg.name != null) "--name ${cfg.name}"}''
          ''${optionalString (cfg.in-peers != null) "--in-peers ${toString cfg.in-peers}"}''
          ''${optionalString (cfg.out-peers != null) "--out-peers ${toString cfg.out-peers}"}''
          ''${optionalString (cfg.listen-addr != null) "--listen-addr ${cfg.listen-addr}"}''
          ''${optionalString (cfg.log != null) "--log ${cfg.log}"}''
          ''${optionalString (cfg.port != null) "--port ${toString cfg.port}"}''
          ''${optionalString (cfg.rpc-port != null) "--rpc-port ${toString cfg.rpc-port}"}''
          ''${optionalString (cfg.reserved-nodes != null) "--reserved-nodes ${cfg.reserved-nodes}"}''
          ''${optionalString (cfg.rpc-cors != null) "--rpc-cors ${cfg.rpc-cors}"}''
          ''${optionalString (cfg.telemetry-url != null) "--telemetry-url ${cfg.telemetry-url}"}''
          ''${optionalString (cfg.pool-kbytes != null) "--pool-kbytes ${toString cfg.pool-kbytes}"}''
          ''${optionalString (cfg.pool-limit != null) "--pool-limit ${toString cfg.pool-limit}"}''
          ''${optionalString (cfg.pruning != 256) "--pruning  ${toString cfg.pruning}"}''
          ''${optionalString (cfg.ws-max-connections != null) "--ws-max-connections ${toString cfg.ws-max-connections}"}''
          ''${optionalString (cfg.offchain-worker != null) "--offchain-worker ${cfg.offchain-worker}"}''
          ''${optionalString (cfg.node-key != null) "--node-key  ${cfg.node-key}"}''                             
          ''${optionalString (cfg.node-key-type != null) "--node-key-type  ${cfg.node-key-type}"}''
          ''${optionalString (cfg.node-key-file != null) "--node-key-file  ${cfg.node-key-file}"}''
          ''${optionalString (cfg.validator == true) "--validator"}''
          ''${optionalString (cfg.grafana-external == true) "--grafana-external"}''
          ''${optionalString (cfg.grafana-port != null) "--grafana-port ${toString cfg.grafana-port}"}''
        ];
        User = cfg.user;
        Group = cfg.group;
        UMask = "0007";
        WorkingDirectory = varDir;
      };
    };
  };
}
