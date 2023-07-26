{ lib
, buildPythonPackage
, fetchPypi
, more-itertools
, requests
, base58
}:

buildPythonPackage rec {
  pname = "scalecodec";
  version = "1.0.34";
  GITHUB_REF="refs/tags/v1.0.34";

  src = fetchPypi {
    inherit pname version;
    sha256 = "16lcmfk4f3940760n5d5zm5l3wanhs59d8z94gcgswbnd38fdlrh";
  };

  propagatedBuildInputs = [ more-itertools requests base58 ];  # зависимости

  meta = {
    description = "Substrate RPCs output scale decodec";
    homepage = "https://polkascan.github.io/py-scale-codec/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vourhey ];
  };
}
