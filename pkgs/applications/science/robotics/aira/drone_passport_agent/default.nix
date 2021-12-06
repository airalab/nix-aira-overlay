{ lib
, fetchFromGitHub
, robonomics_comm
, buildRosPackage
, pkgs
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "drone_passport_agent";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "DistributedSky";
    repo = "${pname}";
    rev = "c580c3944b6a589c0ef4474d180a9f7a786cbb58";
    sha256 = "sha256:0mbar0p9kgxqrvyx4apbx8l8vilbcz3l3cb31x1cgrbjlmk0sh9n";
  };
  propagatedBuildInputs = [
    robonomics_comm
    pkgs.python3Packages.flask-restful
    pkgs.python3Packages.pinatapy
  ];

  meta = with lib; {
    description = "ROS-enabled drone passport agent";
    homepage = http://github.com/DistributedSky/drone_passport_agent;
    license = licenses.bsd3;
    maintainers = [ maintainers.vourhey ];
  };
}

