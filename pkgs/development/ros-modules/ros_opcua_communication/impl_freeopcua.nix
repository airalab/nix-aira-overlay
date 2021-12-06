{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, roscpp
, ros_opcua_srvs
, freeopcua
, libxml2
, pkg-config
}:

let
  pname = "ros_opcua_impl_freeopcua";
  version = "0.2.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/${pname}-0";
    sha256 = "1b1rcpma4dzvg3z2jymdsacqrzbvki97cfbvbra0gik19i6r2pz0";
  };

  propagatedBuildInputs = [ catkin roscpp ros_opcua_srvs freeopcua libxml2 pkg-config ];

  meta = with lib; {
    description = "Bindings for freeopcua - Open Source C++ OPC-UA Server and Client Library";
    homepage = http://wiki.ros.org/ros_opcua_impl_freeopcua;
    license = licenses.lgpl3;
    maintainers = [ maintainers.akru ];
  };
}
