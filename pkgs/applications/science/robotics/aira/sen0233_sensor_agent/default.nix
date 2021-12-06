{ lib
, fetchFromGitHub
, buildRosPackage
, robonomics_comm
, python3Packages
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "sen0233_sensor_agent";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "vourhey";
    repo = "${pname}";
    rev = "4ab957dfcc32324b7b83eebb6ecbcc559bb0b8ac";
    sha256 = "sha256:06d2x2gh2l74xkbz6sfiph4sx690426in125s787324lqmq0kmli";
  };

  propagatedBuildInputs = [ robonomics_comm python3Packages.pyserial ];

  meta = with lib; {
    description = "Agent works with SEN0233 sensor and publishes data on demand";
    homepage = http://github.com/vourhey/sen0233_sensor_agent;
    license = licenses.bsd3;
    maintainers = with maintainers; [ vourhey ];
  };
}

