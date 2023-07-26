{ lib
, buildPythonPackage
, fetchPypi
, scalecodec
, websocket-client
, py-sr25519-bindings
, py-ed25519-bindings
, py-bip39-bindings
, base58
, requests
, xxhash
, ecdsa
, pycryptodome
, eth-keys
#, python3Packages
}:

#let url = "https://files.pythonhosted.org/packages/d9/29/64ff51209e008784cd66d09952d6a956810c4338f56c4e3de2604da5fd83/substrate_interface-1.1.2-py3-none-any.whl";

#in 
buildPythonPackage rec {
  pname = "substrate-interface";
  version = "1.2.2";
  format = "wheel";

  src = fetchPypi {
    inherit version format pname;
    sha256 = "1rybh1bsbmn15mc6lhswrlz53qww4vni5q0fa6qw5i1pi18s5fr7";

    dist = "cp38";
    python = "py3";
    abi = "nane";
    platform = "any";
  };


#  src = fetchPypi {
#    inherit pname version;
#    sha256 = "1rybh1bsbmn15mc6lhswrlz53qww4vni5q0fa6qw5i1pi18s5fr7";
#  };

#  buildInputs = [
#    base58
#    requests
#    xxhash
#    pycryptodome
#    eth-keys
#    ecdsa
#  ];

#  propagatedBuildInputs =  [
#    scalecodec
#    websocket-client
#    py-sr25519-bindings
#    py-ed25519-bindings
#    py-bip39-bindings
#    ecdsa
#    pycryptodome
#  ];  # зависимости

  doCheck=false;
  
  meta = {
    description = "interfacing with a Substrate node version 1.1.2";
    homepage = "https://github.com/polkascan/py-substrate-interface";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ vourhey ];
  };
}

