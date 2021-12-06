{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.webrtc-star;
in

{

  ###### interface

  options = {

    services.webrtc-star = {

      enable = mkEnableOption "Enable LibP2P WebRTC star service"; 

      port = mkOption {
        type = types.int;
        default = 9090;
        description = "Specify a port number server to listen to. Default: 9090";
      };
    };

  };


  ###### implementation

  config = mkIf config.services.webrtc-star.enable {

    systemd.services.webrtc-star =
      {
        description = "LibP2P WebRTC star";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          User = "nobody";
          ExecStart = "${pkgs.nodePackages.libp2p-webrtc-star}/bin/webrtc-star --port ${toString cfg.port}";
          Restart = "always";
        };
      };

  };

}
