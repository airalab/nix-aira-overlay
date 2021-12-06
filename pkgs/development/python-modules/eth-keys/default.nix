{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
}:

let
  pname = "eth-keys";
  version = "0.2.0-beta.3";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "09xp6x5x4qqa34q1z8r70vk7di3pn9c85myfw81sd2ppqm8hidlg";
  };

  propagatedBuildInputs = [ eth-utils ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Common API for Ethereum key operations";
    homepage = https://github.com/ethereum/eth-keys;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
