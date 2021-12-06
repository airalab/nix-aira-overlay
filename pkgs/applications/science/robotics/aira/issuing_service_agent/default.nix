{ lib
, fetchFromGitHub
, buildRosPackage
, robonomics_comm
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "issuing-service-agent";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "DAO-IPCI";
    repo = "issuing_agent";
    rev = "628537d4d621b399031d25e35f4ad27ab04073b9";
    sha256 = "sha256:0mz87i6703kmcmjvdx1wqwpy2zr896y6hqpz5p7kgqrk2pdwpnab";
  };

  propagatedBuildInputs = [ robonomics_comm ];

  meta = with lib; {
    description = "The agent is responsible for checking the data and issuing the green certificates";
    homepage = http://github.com/DAO-IPCI/issuing_agent;
    license = licenses.bsd3;
    maintainers = with maintainers; [ vourhey ];
  };
}

