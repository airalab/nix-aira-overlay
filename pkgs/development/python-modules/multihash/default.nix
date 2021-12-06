{ lib
, buildPythonPackage
, fetchFromGitHub
, base58
}:

buildPythonPackage rec {
  pname = "multihash";
  version = "0.8.2";

  src = fetchFromGitHub {
    owner = "ivilata";
    repo = "pymultihash";
    rev = "3b4ea39e132b5f713cdd745fc6ff117f65116c40";
    sha256 = "0wdxrxss1rv7rrydnwnb2wbfv5nazlm6n6mv7hx61hpblwhyfq9y";
  };

  patches = [ ./base58-encoding-fix.patch ];

  propagatedBuildInputs = [ base58 ];

  doCheck = false;

  meta = with lib; {
    description = "Implementation of the multihash specification in Python";
    homepage = https://github.com/multiformats/multihash;
    license = licenses.mit;
    maintainers = [ maintainers.strdn ];
  };
}
