{ lib
, buildRosPackage
, fetchFromGitHub
, djiosdk
, nav_msgs
, roscpp
, rospy
, sensor_msgs
, tf
}:

buildRosPackage rec {
  name = "${pname}-${version}";
  pname = "dji_sdk";
  version = "3.7.0";

  src = fetchFromGitHub {
    owner = "dji-sdk";
    repo = "Onboard-SDK-ROS";
    rev = version;
    sha256 = "1ikci92clia90ysy2g234gdwhc0jwhls1cwnh94jghsaxincxm4x";
  };

  patches = [ ./non-ascii-genmsg-fix.patch ];
  postPatch = ''
    rm -rf dji_sdk_demo
    mv dji_sdk/* .
    rmdir dji_sdk
    sed -i '/catkin_python_setup()/d' CMakeLists.txt
  '';

  buildInputs = [ djiosdk ];
  propagatedBuildInputs = [ tf nav_msgs roscpp rospy sensor_msgs ];

  meta = with lib; {
    description = "Official ROS packages for DJI onboard SDK.";
    homepage = https://github.com/dji-sdk/Onboard-SDK-ROS;
    maintainers = [ maintainers.akru ];
  };
}
