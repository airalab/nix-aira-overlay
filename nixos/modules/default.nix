{ ... }: {
  imports = [
    ./services/network-filesystems/ipfs.nix
    ./services/networking/websocket-star.nix
    ./services/networking/webrtc-star.nix
    ./services/robonomics/ipfs-subscriber.nix
    ./services/robonomics/liability.nix
    ./services/robonomics/liability-nightly.nix
    ./services/robonomics/erc20.nix
    ./services/robonomics/erc20-nightly.nix
    ./services/robonomics/xrtd.nix
    ./services/robonomics/substrate-node-robonomics.nix
    ./services/robonomics/issuing-service.nix
    ./services/robonomics/drone_passport.nix
    ./services/robonomics/drone_flight_report.nix
    ./services/robonomics/sen0233.nix
    ./services/robonomics/substrate_sensor.nix
    ./services/robonomics/sensors-connectivity.nix
  ];
}
