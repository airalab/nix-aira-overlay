self: super:
{
  catkin = super.rosPackages.noetic.catkin;
  ros_comm = super.rosPackages.noetic.ros-comm;
  rosserial = super.rosPackages.noetic.rosserial;
  buildRosPackage = super.rosPackages.noetic.buildRosPackage;
  roslint = super.rosPackages.noetic.roslint; 
  nav_msgs = super.rosPackages.noetic.nav-msgs;
  roscpp = super.rosPackages.noetic.roscpp;
  rospy = super.rosPackages.noetic.rospy;
  sensor_msgs = super.rosPackages.noetic.sensor-msgs;
  tf = super.rosPackages.noetic.tf;
  tf2_ros = super.rosPackages.noetic.tf2-ros;
  tf2_eigen = super.rosPackages.noetic.tf2-eigen;
  diagnostic_updater = super.rosPackages.noetic.diagnostic-updater;
  geographic_msgs = super.rosPackages.noetic.geographic-msgs;
  std_srvs = super.rosPackages.noetic.std-srvs;
  rosconsole = super.rosPackages.noetic.rosconsole;
  pluginlib = super.rosPackages.noetic.pluginlib;
  angles = super.rosPackages.noetic.angles;
  libmavconn = super.rosPackages.noetic.libmavconn;
  rosconsole_bridge = super.rosPackages.noetic.rosconsole-bridge;
  eigen_conversions = super.rosPackages.noetic.eigen-conversions;
  mavros = super.rosPackages.noetic.mavros;
  mavros_msgs = super.rosPackages.noetic.mavros-msgs;
  actionlib = super.rosPackages.noetic.actionlib;
  message_generation = super.rosPackages.noetic.message-generation;
  std_msgs = super.rosPackages.noetic.std-msgs;
} 
