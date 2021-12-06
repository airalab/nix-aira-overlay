{ lib
, robonomics_comm
, rosserial
, buildRosPackage
, fetchFromGitHub
 }:

 buildRosPackage rec {
  version = "0.2.1";
  pname = "robonomics_tutorials";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_tutorials";
    rev = "v${version}";
    sha256 = "0klf79b40m3fkxwrviayv9hwi9s3djz9acr6akxanwfv42pblj1q";
  };

  preConfigure = ''
      catkin_init_workspace
  '';

  propagatedBuildInputs = [ robonomics_comm rosserial ];

  meta = with lib; {
    description = "Robonomics tutorials stack";
    homepage = http://github.com/airalab/robonomics_tutorials;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
