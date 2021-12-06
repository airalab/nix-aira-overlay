{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, message_generation
, std_msgs
, rospy
}:

let
  pname = "robonomics_game_warehouse";
  version = "0.0.0-0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_game";
    rev = "release/${pname}-0";
    sha256 = "0znzc4kfdpqlqcxcm8wnq33ds42zszmricr0q7wgm0l5cf6k0dlc";
  };

  propagatedBuildInputs = [ catkin message_generation std_msgs rospy ];

  meta = with lib; {
    description = "Robonomics game virtual warehouse nodes";
    homepage = http://github.com/airalab/robonomics_game;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
