{ lib
, buildRosPackage
, fetchFromGitHub
, ros_comm
, actionlib
, ros_opcua_communication
, python3Packages
}:

let
  pname = "robonomics_dev";
  version = "2019.11.07";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "${pname}";
    rev = "0da9937abfdd89287ea31cfc2f24cd8bb4a46437";
    sha256 = "0gdsbp5hnwk35n6gx5czd531y2ng30k9bz5hqwkmiivpfjni5dc9";
  };

  preConfigure = ''
      catkin_init_workspace
  '';

  propagatedBuildInputs = with python3Packages;
  [ ros_comm actionlib ros_opcua_communication ipfshttpclient
    numpy web3 google_api_python_client voluptuous multihash python-persistent-queue
  ];

  meta = with lib; {
    description = "Robonomics development kit";
    homepage = http://github.com/airalab/robonomics_dev;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
