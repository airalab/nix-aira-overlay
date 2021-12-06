{ lib
, python3
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "pinatapy";
  version = "0.1.3";

  propagatedBuildInputs = with python3Packages; [ requests importlib-metadata ];

  src = python3Packages.fetchPypi {
    inherit version;
    pname  = "pinatapy-vourhey";
    sha256 = "058gmr162z9xbazb6kg50b75hfib37q7wxaihhdmq0p02ha8sswp";
  };

  doCheck = false;

  meta = with lib; {
    description = "Non-official Pinata.cloud library.";
    homepage = https://github.com/vourhey/pinatapy;
    license = licenses.bsd3;
    maintainers = with maintainers; [ vourhey ];
  };
}

