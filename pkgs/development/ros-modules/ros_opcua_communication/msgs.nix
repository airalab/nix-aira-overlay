{ lib
, buildRosPackage
, fetchFromGitHub
, catkin
, message_generation
, std_msgs
}:

let
  pname = "ros_opcua_msgs";
  version = "0.2.0";

in buildRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/${pname}-0";
    sha256 = "0rwxvvlsv4p0jq98dvigx2kyc0c58a4xqrs3l4sp6h27rcxpb353";
  };

  propagatedBuildInputs = [ catkin message_generation std_msgs ];

  meta = with lib; {
    description = "Common used ROS OPC-UA messages";
    homepage = http://wiki.ros.org/ros_opcua_communication;
    license = licenses.lgpl3;
    maintainers = [ maintainers.akru ];
  };
}
