{ lib
, buildPythonPackage
, fetchPypi
, more-itertools
, requests
, base58-2_0_1
}:

buildPythonPackage rec {
  pname = "scalecodec";
  version = "1.0.23";
  GITHUB_REF="refs/tags/v1.0.23";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256:11s0lzy6hskvrxfd62y3kwhshjzkvp3x3jl0c8w2pzn21v177g5a";
  };

  propagatedBuildInputs = [ more-itertools requests base58-2_0_1 ];  # зависимости

  meta = {
    description = "Substrate RPCs output scale decodec";
    homepage = "https://polkascan.github.io/py-scale-codec/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vourhey ];
  };
}