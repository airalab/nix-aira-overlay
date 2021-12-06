{ lib
, ros_comm
, buildRosPackage
, python3Packages
, python3
, fetchFromGitHub
}:

buildRosPackage rec {
  version = "1.1.1";
  pname = "robonomics_comm";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "v${version}";
    sha256 = "1k6357piyzrd2f2mv4x0b0nxdg0j2pvpqvinc9vcbj9aij182q9n";
  };

  preConfigure = ''
      catkin_init_workspace
  '';

  propagatedBuildInputs = with python3Packages;
  [ ros_comm web3 voluptuous ipfshttpclient base58 python-persistent-queue setuptools ];
docheck = false;
  postInstall = ''
    patch $out/lib/${python3.libPrefix}/site-packages/ethereum_common/msg/_UInt256.py $src/ethereum_common/msg/_UInt256.py.patch
  '';

  meta = with lib; {
    description = "Robonomics communication stack";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
