{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, ros_opcua_msgs
, ros_opcua_srvs
, ros_opcua_impl_freeopcua
}:

let
  pname = "ros_opcua_communication";
  version = "0.2.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "${pname}";
    rev = "release/${pname}-0";
    sha256 = "1plmbc04xd289vsdicvxmadgxjcvrz1gl56bdprp2j6dk62vvzb3";
  };

  propagatedBuildInputs = [ catkin ros_opcua_msgs ros_opcua_srvs ros_opcua_impl_freeopcua ];

  meta = with lib; {
    description = "ROS bidings for different open-source OPC-UA implementations";
    homepage = http://wiki.ros.org/ros_opcua_communication;
    license = licenses.lgpl3;
    maintainers = [ maintainers.akru ];
  };
}
