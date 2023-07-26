{ lib, python, buildPythonPackage, fetchPypi, pythonPackages, setuptools }:

buildPythonPackage rec {
  pname = "sensors_connectivity";
  version = "1.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 ="0vzy92il2524w0frwlwv53xdp7zd5mi2fi9rplimads7wk2f48nb";
  };

  propagatedBuildInputs =  with pythonPackages; [ 
    pyserial
    sentry-sdk
    robonomics-interface
    pynacl
    pyyaml
    requests
    ipfshttpclient
    pinatapy
    netifaces
    paho-mqtt
  ];

  meta = with lib; {
    description = "Aira source package to input data from sensors.";
    homepage = "https://github.com/airalab/sensors-connectivity";
    license = licenses.gpl3;
    maintainers = with maintainers; [ spd ];
  };
}
