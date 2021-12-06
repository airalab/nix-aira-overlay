{ lib
, fetchurl
, buildPythonPackage
, eth-utils
}:

let
  pname = "hexbytes";
  version = "0.2.1";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://pypi/${builtins.substring 0 1 pname}/${pname}/${name}.tar.gz";
    sha256 = "0nilaqihqlnkqzvaxzz8mfygxb5661wrmjj39yrpxz2jgwwwygqj";
  };

  propagatedBuildInputs = [ eth-utils ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Python `bytes` subclass that decodes hex, with a readable console output";
    homepage = https://github.com/ethereum/hexbytes;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
