{ lib
, buildPythonPackage
, fetchPypi
, more-itertools
, requests_38
, base58-2_0_1
}:

buildPythonPackage rec {
  pname = "scalecodec";
  version = "1.0.28";
  GITHUB_REF="refs/tags/v1.0.28";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256:1ncccx9zxj617qwp23c3p0zczbhxv2qkwp4cyf95825wcqx0ikm3";
  };

  propagatedBuildInputs = [ more-itertools requests_38 base58-2_0_1 ];  # зависимости

  meta = {
    description = "Substrate RPCs output scale decodec";
    homepage = "https://polkascan.github.io/py-scale-codec/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vourhey ];
  };
}