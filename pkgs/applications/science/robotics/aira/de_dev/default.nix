{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, ros_comm
, dji_sdk
, mavros
, robonomics_comm
, python3Packages
}:

let
  pname = "de_dev";
  version = "0.0.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "tuuzdu";
    repo = "${pname}";
    rev = "master";
    sha256 = "1gy0bf3zwn77n9a51yf5hlqabp3r61iyblahc3ib76vvzw2hqn7g";
  };

  propagatedBuildInputs = with python3Packages;
  [ catkin ros_comm dji_sdk mavros
    base58 pexpect ipfshttpclient numpy web3 pyserial
    robonomics_comm voluptuous
  ];

  meta = with lib; {
    description = "Drone Employee development kit";
    homepage = http://github.com/tuuzdu/de_dev;
    license = licenses.bsd3;
    maintainers = [ maintainers.tuuzdu ];
  };
}
