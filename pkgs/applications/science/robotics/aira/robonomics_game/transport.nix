{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, actionlib
, robonomics_comm
, ros_opcua_communication
, robonomics_game_warehouse
}:

let
  pname = "robonomics_game_transport";
  version = "0.0.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_game";
    rev = "release/${pname}-0";
    sha256 = "1h87nyxb26v9zzm6sssdwy9c53a5hg3642xb9kn1bzz2z2wyzvc3";
  };

  propagatedBuildInputs =
  [ catkin actionlib robonomics_comm ros_opcua_communication robonomics_game_warehouse ];

  meta = with lib; {
    description = "Robonomics game transporter driver & logic";
    homepage = http://github.com/airalab/robonomics_game;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
