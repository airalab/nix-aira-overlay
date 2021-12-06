{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, actionlib
, robonomics_comm
, ros_opcua_communication
, robonomics_game_warehouse
, python3Packages
}:

let
  pname = "robonomics_game_plant";
  version = "0.0.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_game";
    rev = "release/${pname}-0";
    sha256 = "12a5iqhlai162sciar2mhag9f0gzznfpni159nj6x0qhbj7p8a85";
  };

  propagatedBuildInputs = with python3Packages;
  [ catkin actionlib robonomics_comm google_api_python_client 
    ros_opcua_communication robonomics_game_warehouse ];

  meta = with lib; {
    description = "Robonomics game plant driver & logic";
    homepage = http://github.com/airalab/robonomics_game;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
