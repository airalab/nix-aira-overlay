{ lib
, fetchPypi
, python3Packages
, substrate-interface
, xxhash
, eth-keys

}:

python3Packages.buildPythonPackage rec {
  pname = "robonomics-interface";
  version = "0.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256:0djzsihrmm38hynjdl9ysmi7bymh4yz8rhr56caikrgl6qgin9cw";
  };

  buildInputs = [
    substrate-interface
    xxhash
    eth-keys
  ];

  doCheck=false;

  meta = {
    description = "A simple wrapper over https://github.com/polkascan/py-substrate-interface used to facilitate writing code for applications using Robonomics.";
    homepage = "https://github.com/Multi-Agent-io/robonomics-interface";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ tubleronchik ];
  };
}
