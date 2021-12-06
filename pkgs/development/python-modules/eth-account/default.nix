{ lib
, fetchFromGitHub 
, buildPythonPackage
, attrdict
, eth-keyfile
, eth-utils
, eth-rlp
}:

let
  pname = "eth-account";
  version = "0.2.2";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "10i0kizhsb8wbmrsxf09j9gc36mrgcvi1pn424zkfl5rphlqk1m8";
  };

  propagatedBuildInputs = [ attrdict eth-keyfile eth-utils eth-rlp ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Sign Ethereum transactions and messages with local private keys";
    homepage = https://github.com/ethereum/eth-account;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
