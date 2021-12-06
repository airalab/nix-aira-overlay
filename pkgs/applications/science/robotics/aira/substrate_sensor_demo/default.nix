{ lib
, fetchFromGitHub
, buildRosPackage
, robonomics_comm
, python3Packages
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "substrate_sensor_demo";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "${pname}";
    rev = "03f3e472317305aa79e95fa3effaf3a59111810a";
    sha256 = "sha256:0nl0h0lq058qwnn6m77qpkwrx5sifpjvl1c8ha3jyzd5cpvhmbn8";
  };

  propagatedBuildInputs = [ robonomics_comm python3Packages.pyserial ];

  meta = with lib; {
    description = "Agent works with SEN0233 sensor and publishes data with specified interval";
    homepage = http://github.com/airalab/substrate_sensor_demo;
    license = licenses.bsd3;
    maintainers = with maintainers; [ vourhey ];
  };
}

