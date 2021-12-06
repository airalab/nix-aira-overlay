{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
, hexbytes
, rlp
}:

let
  pname = "eth-rlp";
  version = "0.2.1";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "13qhvq8agp6khg0nlmzxp5m1hv7snwxq9bvsz84kgm5ggjq0b6q4";
  };

  propagatedBuildInputs = [ eth-utils hexbytes rlp ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "RLP definitions for common Ethereum objects in Python";
    homepage = https://github.com/ethereum/eth-rlp;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
