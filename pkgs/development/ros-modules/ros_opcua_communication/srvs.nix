{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, message_generation
, std_srvs
, ros_opcua_msgs
}:

let
  pname = "ros_opcua_srvs";
  version = "0.2.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/${pname}-0";
    sha256 = "132q14h4d8yr5kljgla5az2zzmclck0qkqprcdm00bhdbmixm0pw";
  };

  propagatedBuildInputs = [ catkin message_generation std_srvs ros_opcua_msgs ];

  meta = with lib; {
    description = "Common used ROS OPC-UA services";
    homepage = http://wiki.ros.org/ros_opcua_communication;
    license = licenses.lgpl3;
    maintainers = [ maintainers.akru ];
  };
}
