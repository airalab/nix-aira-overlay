{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, robonomics_game_transport
, robonomics_game_warehouse
, robonomics_game_plant
, robonomics_game_supply
}:

let
  pname = "robonomics_game";
  version = "0.0.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_game";
    rev = "release/${pname}-0";
    sha256 = "02rav3lfvs8hc236415q8razzq0yc66igg7fvss94bskb30950cq";
  };

  propagatedBuildInputs =
  [ catkin robonomics_game_transport robonomics_game_warehouse
    robonomics_game_plant robonomics_game_supply ];

  meta = with lib; {
    description = "Robonomics game meta-package";
    homepage = http://github.com/airalab/robonomics_game;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
