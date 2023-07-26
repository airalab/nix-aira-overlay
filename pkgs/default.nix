self: super:
{

  
  robonomics-tools = #broken
    let tools = super.haskellPackages.callPackage ./applications/science/robotics/aira/robonomics-tools.nix { };
    in super.haskell.lib.overrideCabal (super.haskell.lib.justStaticExecutables tools) { };


  dji_sdk = super.callPackage ./development/ros-modules/dji_sdk { };
  djiosdk = super.callPackage ./development/libraries/science/robotics/djiosdk { };
  ros_opcua_msgs = super.callPackage ./development/ros-modules/ros_opcua_communication/msgs.nix { };
  ros_opcua_srvs = super.callPackage ./development/ros-modules/ros_opcua_communication/srvs.nix { };
  ros_opcua_impl_freeopcua = super.callPackage ./development/ros-modules/ros_opcua_communication/impl_freeopcua.nix { };
  ros_opcua_communication = super.callPackage ./development/ros-modules/ros_opcua_communication { };
  freeopcua = super.callPackage ./development/libraries/freeopcua { };

  complier_service = super.callPackage ./applications/science/robotics/aira/complier_service {  };
  de_dev = super.callPackage ./applications/science/robotics/aira/de_dev { };
  robonomics_comm = super.callPackage ./applications/science/robotics/aira/robonomics_comm { };
  robonomics_comm-nightly = super.callPackage ./applications/science/robotics/aira/robonomics_comm/nightly.nix { };
  robonomics_tutorials = super.callPackage ./applications/science/robotics/aira/robonomics_tutorials { };
  robonomics_contracts = super.callPackage ./applications/science/robotics/aira/robonomics_contracts { };
  drone_flight_report = super.callPackage ./applications/science/robotics/aira/drone_flight_report { };
  drone_passport_agent = super.callPackage ./applications/science/robotics/aira/drone_passport_agent { };
  hello_aira = super.callPackage ./applications/science/robotics/aira/hello_aira { };
  issuing-service-agent = super.callPackage ./applications/science/robotics/aira/issuing_service_agent { };
  robonomics_dev = super.callPackage ./applications/science/robotics/aira/robonomics_dev { };
  robonomics_game_transport = super.callPackage ./applications/science/robotics/aira/robonomics_game/transport.nix { };
  robonomics_game_warehouse = super.callPackage ./applications/science/robotics/aira/robonomics_game/warehouse.nix { };
  robonomics_game_plant = super.callPackage ./applications/science/robotics/aira/robonomics_game/plant.nix { };
  robonomics_game_supply = super.callPackage ./applications/science/robotics/aira/robonomics_game/supply.nix { };
  robonomics_game = super.callPackage ./applications/science/robotics/aira/robonomics_game { };
  sen0233_sensor_agent = super.callPackage ./applications/science/robotics/aira/sen0233_sensor_agent { };
  sensors-connectivity = super.callPackage ./applications/science/robotics/aira/sensors-connectivity { };
  substrate_sensor_demo = super.callPackage ./applications/science/robotics/aira/substrate_sensor_demo {  };

  robonomics-bin = super.callPackage ./applications/blockchains/robonomics { };
  ipfs_0_9_0 = super.callPackage ./applications/networking/ipfs { };
}     

