{ lib
, fetchFromGitHub
, buildRosPackage
, robonomics_comm
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "drone_flight_report";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "DistributedSky";
    repo = "${pname}";
    rev = "bb51e628e50552cc065b2a782ab1936f787d34f5";
    sha256 = "sha256:0n0dcqx1z9kfbmznfk2nxcdil55sskay170xh1q23q38r1djlkrs";
  };

  propagatedBuildInputs = [ robonomics_comm ];

  meta = with lib; {
    description = "Service to register a drone flight via Robonmics Network";
    homepage = http://github.com/DistributedSky/drone_flight_report;
    license = licenses.bsd3;
    maintainers = with maintainers; [ vourhey ];
  };
}

