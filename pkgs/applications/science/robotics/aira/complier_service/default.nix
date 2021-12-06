{ lib
, fetchFromGitHub
, buildRosPackage
, robonomics_comm
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "complier_service";
  version = "master";

  src = fetchFromGitHub {
    owner = "DAO-IPCI";
    repo = "${pname}";
    rev = "0d3c19841b1d77bfedc91da89378b1bbfcadd262";
    sha256 = "sha256:03ddkkkalxjx0kk1djz6y6zx4r1f8adaacyzwdivfgzis6g00wgk";
  };

  propagatedBuildInputs = [ robonomics_comm ];

  meta = with lib; {
    description = "The service offsets CO2 footprint by burning VCU tokens";
    homepage = http://github.com/DAO-IPCI/complier_service;
    license = licenses.bsd3;
    maintainers = with maintainers; [ vourhey ];
  };
}

