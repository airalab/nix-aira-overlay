{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "python_persistent_queue";
  version = "1.3.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1lnr9i8sdhqpmn1jgcix8vslg2xzkprx2jbsq1lz5iyb2hi9zydw";
  };

  doCheck = false;

  meta = with lib; {
    description = "Implementation of a persistent queue in Python. ";
    homepage = "https://github.com/philipbl/python-persistent-queue";
    license = licenses.mit;
  };

}
