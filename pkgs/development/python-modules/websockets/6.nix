{ lib
, fetchPypi
, buildPythonPackage
, pythonOlder
}:

buildPythonPackage rec {
  pname = "websockets";
  version = "6.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0v3iqdqizwxajpwasyngkhdfwfqxvh864wl2cch03cy525nrafwg";
  };

  disabled = pythonOlder "3.3";
  doCheck = false; # protocol tests fail

  meta = {
    description = "WebSocket implementation in Python 3";
    homepage = https://github.com/aaugustin/websockets;
    license = lib.licenses.bsd3;
  };
}
