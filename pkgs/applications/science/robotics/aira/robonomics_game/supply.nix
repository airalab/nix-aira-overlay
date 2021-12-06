{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, actionlib
, robonomics_comm
, ros_opcua_communication
, robonomics_game_plant
}:

let
  pname = "robonomics_game_supply";
  version = "0.0.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_game";
    rev = "release/${pname}-0";
    sha256 = "11smc5l4pb2m7i4pvqmxl722pla48jzn3mhjhw91s4vmmf13ivnz";
  };

  propagatedBuildInputs =
  [ catkin actionlib robonomics_comm ros_opcua_communication robonomics_game_plant ];

  meta = with lib; {
    description = "Robonomics game plant supply chains";
    homepage = http://github.com/airalab/robonomics_game;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
