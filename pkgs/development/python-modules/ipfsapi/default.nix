{ lib
, buildPythonPackage
, fetchPypi
, six
, requests
, isPy27
}:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "ipfsapi"; 
  version = "0.4.4";

  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    sha256 = "17ddd54dxvvqc7a7bx0w8jp9bjcfik120lkks9nk4ph4mcn5zplg";
  };

  propagatedBuildInputs = [ requests ];

  meta = with lib; {
    description = "A python client library for the IPFS API";
    license = licenses.mit;
    maintainers = with maintainers; [ mguentner ];
    homepage = "https://pypi.python.org/pypi/ipfsapi";
  };
}
