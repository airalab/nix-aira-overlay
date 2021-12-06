{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-keys
}:

let
  pname = "eth-keyfile";
  version = "0.5.1";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "1lgw24xl2g670qaajicjhkibl0gvcyqbxrnhlsadw8z78lxv6v90";
  };

  propagatedBuildInputs = [ eth-keys ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "A library for handling the encrypted keyfiles used to store ethereum private keys";
    homepage = https://github.com/ethereum/eth-keyfile;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
